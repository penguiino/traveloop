import 'package:flutter/material.dart';
import '../models/container.dart';
import '../providers/trip_provider.dart';
import 'package:provider/provider.dart';

class ContainerEditScreen extends StatefulWidget {
  final TripContainer? container; // The container to edit, if null, we're creating a new one

  ContainerEditScreen({this.container});

  @override
  _ContainerEditScreenState createState() => _ContainerEditScreenState();
}

class _ContainerEditScreenState extends State<ContainerEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _type;
  Map<String, dynamic> _details = {};

  @override
  void initState() {
    super.initState();
    // Initialize form fields with existing container data if editing
    if (widget.container != null) {
      _title = widget.container!.title;
      _type = widget.container!.type;
      _details = Map<String, dynamic>.from(widget.container!.details);
    } else {
      _title = '';
      _type = 'City'; // Default type
    }
  }

  void _saveContainer() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      TripContainer newContainer = TripContainer(
        id: widget.container?.id ?? DateTime.now().toString(),
        title: _title,
        type: _type,
        details: _details,
        nestedContainers: widget.container?.nestedContainers ?? [],
      );

      // If editing, update the existing container, otherwise add a new one
      if (widget.container != null) {
        // Update logic here
        // This would typically involve updating the container in the trip
        // and saving it back to the provider or service.
      } else {
        // Add logic here
        Provider.of<TripProvider>(context, listen: false)
            .selectedTrip
            ?.addContainer(newContainer);
      }

      Navigator.of(context).pop(); // Close the screen after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.container == null ? 'Add Container' : 'Edit Container'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveContainer,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              DropdownButtonFormField<String>(
                value: _type,
                decoration: InputDecoration(labelText: 'Type'),
                items: ['City', 'Road', 'Stop', 'Hotel', 'Attraction']
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                  });
                },
                onSaved: (value) {
                  _type = value!;
                },
              ),
              // Add more form fields for details as needed
              // For example, if type is "City", you might ask for coordinates
              TextFormField(
                initialValue: _details['description'] ?? '',
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _details['description'] = value;
                },
              ),
              // Add other detail fields as necessary
            ],
          ),
        ),
      ),
    );
  }
}
