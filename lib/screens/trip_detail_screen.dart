import 'package:flutter/material.dart';
import '../models/container.dart';
import '../models/trip.dart';
import 'container_edit_screen.dart';
import 'share_screen.dart';

class TripDetailScreen extends StatelessWidget {
  final Trip trip;

  const TripDetailScreen({super.key, required this.trip});


  void _editContainer(BuildContext context, TripContainer container) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContainerEditScreen(container: container),
    ));
  }

  void _addContainer(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContainerEditScreen(), // Handle without container
    ));
  }

  void _shareTrip(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ShareScreen(trip: trip),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trip.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareTrip(context),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to trip edit screen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ContainerEditScreen(), // Handle without container
              ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display trip details
            ListTile(
              title: const Text('Trip Name'),
              subtitle: Text(trip.name),
            ),
            ListTile(
              title: const Text('Start Date'),
              subtitle: Text(trip.startDate.toLocal().toString().split(' ')[0]),
            ),
            ListTile(
              title: const Text('End Date'),
              subtitle: Text(trip.endDate.toLocal().toString().split(' ')[0]),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: trip.containers.length,
                itemBuilder: (ctx, index) {
                  final container = trip.containers[index];
                  return ListTile(
                    title: Text(container.title),
                    subtitle: Text('Type: ${container.type}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editContainer(context, container),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addContainer(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
