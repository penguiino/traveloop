import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/trip_list_screen.dart';
import 'screens/trip_detail_screen.dart';
import 'screens/container_edit_screen.dart';
import 'screens/share_screen.dart';
import 'models/trip.dart';

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
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case tripList:
        return MaterialPageRoute(
          builder: (_) => TripListScreen(
            trips: settings.arguments as List<Trip>? ?? [],
          ),
        );
      case tripDetail:
        final trip = settings.arguments as Trip?;
        return MaterialPageRoute(
          builder: (_) => TripDetailScreen(trip: trip),
        );
      case editTrip:
        final trip = settings.arguments as Trip?;
        return MaterialPageRoute(
          builder: (_) => ContainerEditScreen(trip: trip),
        );
      case share:
        return MaterialPageRoute(builder: (_) => ShareScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen()); // Fallback
    }
  }
}
