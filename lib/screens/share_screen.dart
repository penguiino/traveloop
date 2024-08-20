import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/trip.dart';
import '../providers/trip_provider.dart';
import '../services/firebase_service.dart';

class ShareScreen extends StatefulWidget {
  final Trip trip;

  ShareScreen({required this.trip});

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  final _emailController = TextEditingController();
  String _selectedPermission = 'View'; // Default permission

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _shareTrip() async {
    if (_emailController.text.isNotEmpty) {
      try {
        await FirebaseService.shareTrip(
          widget.trip.id,
          _emailController.text,
          _selectedPermission,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Trip shared successfully!')),
        );
        _emailController.clear();
        setState(() {}); // Refresh the UI to show updated list
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sharing trip: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter an email to share with',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => _emailController.clear(),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            DropdownButtonFormField<String>(
              value: _selectedPermission,
              items: ['View', 'Edit']
                  .map((permission) => DropdownMenuItem(
                value: permission,
                child: Text(permission),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPermission = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Permission'),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _shareTrip,
              icon: Icon(Icons.share),
              label: Text('Share Trip'),
            ),
            SizedBox(height: 24),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: FirebaseService.getSharedUsers(widget.trip.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading shared users'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No users have access to this trip.'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {
                        final user = snapshot.data![index];
                        return ListTile(
                          title: Text(user['email']),
                          subtitle: Text('Permission: ${user['permission']}'),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () async {
                              await FirebaseService.removeSharedUser(
                                  widget.trip.id, user['email']);
                              setState(() {}); // Refresh the list
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
