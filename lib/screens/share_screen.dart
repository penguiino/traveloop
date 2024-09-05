import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../services/firebase_service.dart';

class ShareScreen extends StatefulWidget {
  final Trip trip;

  const ShareScreen({super.key, required this.trip});

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  final _emailController = TextEditingController();
  String _selectedPermission = 'View'; // Default permission
  final FirebaseService _firebaseService = FirebaseService(); // Instance of FirebaseService

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _shareTrip() async {
    if (_emailController.text.isNotEmpty) {
      try {
        await _firebaseService.shareTrip(
          widget.trip.id,
          _emailController.text,
          _selectedPermission,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trip shared successfully!')),
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

  Future<List<Map<String, dynamic>>> _getSharedUsers() async {
    try {
      return await _firebaseService.getSharedUsers(widget.trip.id);
    } catch (e) {
      throw Exception('Error fetching shared users: $e');
    }
  }

  Future<void> _removeSharedUser(String email) async {
    try {
      await _firebaseService.removeSharedUser(widget.trip.id, email);
      setState(() {}); // Refresh the list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error removing user: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Trip'),
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
                  icon: const Icon(Icons.clear),
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
              decoration: const InputDecoration(labelText: 'Permission'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _shareTrip,
              icon: const Icon(Icons.share),
              label: const Text('Share Trip'),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _getSharedUsers(), // Use instance method
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading shared users'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No users have access to this trip.'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {
                        final user = snapshot.data![index];
                        return ListTile(
                          title: Text(user['email']),
                          subtitle: Text('Permission: ${user['permission']}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () async {
                              await _removeSharedUser(user['email']);
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
