import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/trip_provider.dart';
import 'trip_detail_screen.dart';
import 'trip_edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final tripProvider = Provider.of<TripProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: tripProvider.loadTrips(authProvider.currentUser!.id),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred!'));
          } else {
            return tripProvider.trips.isEmpty
                ? const Center(child: Text('No trips found. Add a new trip!'))
                : ListView.builder(
              itemCount: tripProvider.trips.length,
              itemBuilder: (ctx, index) {
                final trip = tripProvider.trips[index];
                return ListTile(
                  title: Text(trip.name),
                  subtitle: Text(
                      '${trip.startDate.toLocal()} - ${trip.endDate.toLocal()}'),
                  onTap: () {
                    tripProvider.selectTrip(trip);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TripDetailScreen(trip: trip),
                    ));
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      tripProvider.selectTrip(trip);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TripEditScreen(trip: trip),
                      ));
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TripEditScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
