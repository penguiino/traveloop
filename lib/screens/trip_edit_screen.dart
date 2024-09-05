import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/trip.dart';
import '../providers/trip_provider.dart';

class TripEditScreen extends StatefulWidget {
  final Trip? trip;

  const TripEditScreen({super.key, this.trip});

  @override
  _TripEditScreenState createState() => _TripEditScreenState();
}

class _TripEditScreenState extends State<TripEditScreen> {
  final _nameController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _ownerId = '';

  @override
  void initState() {
    super.initState();
    if (widget.trip != null) {
      _nameController.text = widget.trip!.name;
      _startDateController.text = widget.trip!.startDate.toLocal().toString();
      _endDateController.text = widget.trip!.endDate.toLocal().toString();
      _descriptionController.text = widget.trip!.description;
      _ownerId = widget.trip!.ownerId;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTrip() {
    final name = _nameController.text;
    final startDate = DateTime.parse(_startDateController.text);
    final endDate = DateTime.parse(_endDateController.text);
    final description = _descriptionController.text;

    if (widget.trip != null) {
      // Update existing trip
      Provider.of<TripProvider>(context, listen: false).updateTrip(
        Trip(
          id: widget.trip!.id,
          name: name,
          startDate: startDate,
          endDate: endDate,
          description: description,
          ownerId: _ownerId,
          containers: widget.trip!.containers,
        ),
      );
    } else {
      // Add new trip
      Provider.of<TripProvider>(context, listen: false).addTrip(
        Trip(
          id: '', // Set to empty or generate a new ID
          name: name,
          startDate: startDate,
          endDate: endDate,
          description: description,
          ownerId: _ownerId,
          containers: [],
        ),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trip == null ? 'Add Trip' : 'Edit Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Trip Name'),
            ),
            TextField(
              controller: _startDateController,
              decoration: const InputDecoration(labelText: 'Start Date (yyyy-MM-dd)'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _endDateController,
              decoration: const InputDecoration(labelText: 'End Date (yyyy-MM-dd)'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTrip,
              child: Text(widget.trip == null ? 'Add Trip' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
