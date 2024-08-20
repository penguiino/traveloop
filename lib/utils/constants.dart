import 'package:flutter/material.dart';

// Color palette
const Color primaryColor = Color(0xFF6200EE);
const Color secondaryColor = Color(0xFF03DAC6);
const Color backgroundColor = Color(0xFFF5F5F5);
const Color accentColor = Color(0xFFBB86FC);
const Color errorColor = Color(0xFFB00020);

// Text styles
const TextStyle headingStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);

const TextStyle subheadingStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  color: secondaryColor,
);

const TextStyle bodyStyle = TextStyle(
  fontSize: 16.0,
  color: Colors.black87,
);

const TextStyle buttonTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

// Padding and margins
const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(16.0);
const EdgeInsetsGeometry smallPadding = EdgeInsets.all(8.0);
const EdgeInsetsGeometry largePadding = EdgeInsets.all(24.0);

// Sizes
const double buttonHeight = 48.0;
const double borderRadius = 12.0;

// API and Database constants
const String apiBaseUrl = 'https://api.example.com';
const String tripsCollection = 'trips';

// Shared preferences keys
const String userTokenKey = 'user_token';
const String userPreferencesKey = 'user_preferences';

// Routes
const String homeRoute = '/home';
const String loginRoute = '/login';
const String tripDetailRoute = '/trip_detail';
const String settingsRoute = '/settings';

// Error messages
const String networkErrorMessage = 'Failed to connect to the network. Please try again later.';
const String authenticationErrorMessage = 'Authentication failed. Please check your credentials.';
