import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/trip_detail_screen.dart';
import 'screens/container_edit_screen.dart';
import 'screens/share_screen.dart';
import 'screens/trip_list_screen.dart';
import 'services/auth_service.dart';
import 'services/firebase_service.dart';
import 'providers/auth_provider.dart';
import 'providers/trip_provider.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          primarySwatch: Colors.blue,
          accentColor: accentColor,
          buttonTheme: ButtonThemeData(
            buttonColor: primaryColor,
            textTheme: ButtonTextTheme.primary,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            headline1: bodyStyle,
            bodyText2: bodyStyle,
            headline1: headingStyle,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/login': (context) => LoginScreen(),
          '/trip_list': (context) => TripListScreen(
            trips: [], // Example, replace with actual data
          ),
          '/trip_detail': (context) => TripDetailScreen(
            // Pass trip data as arguments
          ),
          '/edit_trip': (context) => ContainerEditScreen(
            // Pass trip data as arguments
          ),
          '/share': (context) => ShareScreen(),
        },
      ),
    );
  }
}
