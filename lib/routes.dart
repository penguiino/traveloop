import 'package:flutter/material.dart';
import 'package:traveloop/models/trip.dart';
import 'models/container.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/trip_list_screen.dart';
import 'screens/trip_detail_screen.dart';
import 'screens/container_edit_screen.dart';
import 'screens/share_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String tripList = '/trip_list';
  static const String tripDetail = '/trip_detail';
  static const String editTrip = '/edit_trip';
  static const String share = '/share';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case tripList:
        final trips = settings.arguments as List<Trip>? ?? [];
        return MaterialPageRoute(
          builder: (_) => TripListScreen(trips: trips),
        );
      case tripDetail:
        final trip = settings.arguments as Trip?;
        if (trip != null) {
          return MaterialPageRoute(
            builder: (_) => TripDetailScreen(trip: trip),
          );
        }
        return _errorRoute(); // Handle error if no trip argument is provided
      case editTrip:
        final TripContainer? container = settings.arguments as TripContainer?;
        return MaterialPageRoute(
          builder: (_) => ContainerEditScreen(container: container),
        );

      case share:
        final trip = settings.arguments as Trip?;
        if (trip != null) {
          return MaterialPageRoute(
            builder: (_) => ShareScreen(trip: trip),
          );
        }
        return _errorRoute(); // Handle error if no trip argument is provided
      default:
        return _errorRoute(); // Fallback route
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('No route defined for this path'),
        ),
      ),
    );
  }
}
