import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:traveloop/models/trip.dart';
import 'models/container.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/trip_detail_screen.dart';
import 'screens/container_edit_screen.dart';
import 'screens/share_screen.dart';
import 'screens/trip_list_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/trip_provider.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => TripProvider()),
      ],
      child: MaterialApp(
        title: 'Trip Planner',
        theme: ThemeData(
          buttonTheme: const ButtonThemeData(
            buttonColor: primaryColor,
            textTheme: ButtonTextTheme.primary,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            displayLarge: bodyStyle,
            bodyMedium: bodyStyle,
          ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: accentColor),
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => const HomeScreen());
            case '/login':
              return MaterialPageRoute(builder: (context) => const LoginScreen());
            case '/trip_list':
              final trips = settings.arguments as List<Trip>? ?? [];
              return MaterialPageRoute(
                builder: (context) => TripListScreen(trips: trips),
              );
            case '/trip_detail':
              final trip = settings.arguments as Trip;
              return MaterialPageRoute(
                builder: (context) => TripDetailScreen(trip: trip),
              );
            case '/edit_trip':
              final TripContainer? container = settings.arguments as TripContainer?;
              return MaterialPageRoute(
                builder: (context) => ContainerEditScreen(container: container),
              );
            case '/share':
              final trip = settings.arguments as Trip;
              return MaterialPageRoute(
                builder: (context) => ShareScreen(trip: trip),
              );
            default:
              return MaterialPageRoute(builder: (context) => const HomeScreen()); // Fallback
          }
        },
      ),
    );
  }
}
