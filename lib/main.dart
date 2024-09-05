import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/trip_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/trip_detail_screen.dart';
import 'screens/container_edit_screen.dart';
import 'screens/share_screen.dart';
import 'screens/trip_list_screen.dart';
import 'utils/constants.dart';
import 'models/trip.dart';
import 'models/container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  // Initialize AuthProvider
  final authProvider = AuthProvider();
  await authProvider.initializeUser(); // Initialize the authentication state

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (context) => TripProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: accentColor),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          case '/signup':
            return MaterialPageRoute(builder: (context) => const SignupScreen());
          case '/trip_list':
            final trips = settings.arguments as List<Trip>? ?? [];
            return MaterialPageRoute(
              builder: (context) => TripListScreen(trips: trips),
            );
          case '/trip_detail':
            final trip = settings.arguments as Trip?;
            if (trip == null) {
              return MaterialPageRoute(builder: (context) => const HomeScreen());
            }
            return MaterialPageRoute(
              builder: (context) => TripDetailScreen(trip: trip),
            );
          case '/edit_trip':
            final container = settings.arguments as TripContainer?;
            return MaterialPageRoute(
              builder: (context) => ContainerEditScreen(container: container),
            );
          case '/share':
            final trip = settings.arguments as Trip?;
            if (trip == null) {
              return MaterialPageRoute(builder: (context) => const HomeScreen());
            }
            return MaterialPageRoute(
              builder: (context) => ShareScreen(trip: trip),
            );
          default:
            return MaterialPageRoute(builder: (context) => const HomeScreen()); // Fallback
        }
      },
    );
  }
}
