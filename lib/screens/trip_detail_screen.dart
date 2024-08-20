import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/trip.dart';
import '../providers/trip_provider.dart';
import 'container_edit_screen.dart';
import 'share_screen.dart';

class TripDetailScreen extends StatelessWidget {
  final Trip trip;

  TripDetailScreen({required this.trip});

  void _editContainer(BuildContext context, TripContainer container) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContainerEditScreen(container: container),
    ));
  }

  void _addContainer(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContainerEditScreen(),
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
            icon: Icon(Icons.share),
            onPressed: () => _shareTrip(context),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to trip edit screen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ContainerEditScreen(),
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
              title: Text('Trip Name'),
              subtitle: Text(trip.name),
            ),
            ListTile(
              title: Text('Start Date'),
              subtitle: Text(trip.startDate.toLocal().toString().split(' ')[0]),
            ),
            ListTile(
              title: Text('End Date'),
              subtitle: Text(trip.endDate.toLocal().toString().split(' ')[0]),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: trip.containers.length,
                itemBuilder: (ctx, index) {
                  final container = trip.containers[index];
                  return ListTile(
                    title: Text(container.title),
                    subtitle: Text('Type: ${container.type}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
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
        child: Icon(Icons.add),
      ),
    );
  }
}
