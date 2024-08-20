// lib/widgets/trip_card.dart
import 'package:flutter/material.dart';
import '../models/trip.dart'; // Import the Trip model

class TripCard extends StatelessWidget {
  final Trip trip;

  TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(trip.name), // Use 'name' instead of 'title'
        subtitle: Text(trip.description), // Ensure description property is used
        // Other widgets and properties
      ),
    );
  }
}
