import 'package:flutter/foundation.dart';

class AppUser {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final List<String> trips;
  final DateTime createdAt;
  final Map<String, dynamic> metadata;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl = '',
    this.trips = const [],
    required this.createdAt,
    this.metadata = const {},
  });

  // Add method to convert from JSON
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatarUrl'] ?? '',
      trips: List<String>.from(json['trips']),
      createdAt: DateTime.parse(json['createdAt']),
      metadata: json['metadata'] ?? {},
    );
  }

  // Add method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'trips': trips,
      'createdAt': createdAt.toIso8601String(),
      'metadata': metadata,
    };
  }

  // Add method to add a trip to the user's list
  void addTrip(String tripId) {
    trips.add(tripId);
  }

  // Add method to remove a trip from the user's list
  void removeTrip(String tripId) {
    trips.removeWhere((id) => id == tripId);
  }
}
