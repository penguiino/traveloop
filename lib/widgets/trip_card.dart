import 'package:flutter/material.dart';
import '../models/trip.dart'; // Import the Trip model

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback onTap; // Add the onTap parameter

  const TripCard({
    super.key,
    required this.trip,
    required this.onTap, // Add the onTap parameter to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(trip.name), // Use 'name' instead of 'title'
        subtitle: Text(trip.description), // Ensure description property is used
        onTap: onTap, // Handle the tap
      ),
    );
  }
}
