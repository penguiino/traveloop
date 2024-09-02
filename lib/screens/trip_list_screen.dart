import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../widgets/trip_card.dart';

class TripListScreen extends StatelessWidget {
  final List<Trip> trips;

  // Constructor with required parameter
  const TripListScreen({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
      ),
      body: trips.isEmpty
          ? const Center(child: Text('No trips found'))
          : ListView.builder(
        itemCount: trips.length,
        itemBuilder: (ctx, index) {
          final trip = trips[index];
          return TripCard(
            trip: trip,
            onTap: () {
              Navigator.of(context).pushNamed(
                '/trip_detail',
                arguments: trip,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/edit_trip');
        },
        tooltip: 'Add New Trip',
        child: const Icon(Icons.add),
      ),
    );
  }
}
