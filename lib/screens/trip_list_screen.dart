import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/trip_provider.dart';
import '../models/trip.dart';
import '../widgets/trip_card.dart';

class TripListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Trips'),
      ),
      body: tripProvider.trips.isEmpty
          ? Center(child: Text('No trips found'))
          : ListView.builder(
        itemCount: tripProvider.trips.length,
        itemBuilder: (ctx, index) {
          final trip = tripProvider.trips[index];
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
        child: Icon(Icons.add),
        tooltip: 'Add New Trip',
      ),
    );
  }
}
