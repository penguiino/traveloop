import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../services/firebase_service.dart';

class TripService with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Trip> _trips = [];

  List<Trip> get trips => _trips;

  // Load trips from Firebase
  Future<void> loadTrips() async {
    try {
      _trips = await _firebaseService.getTrips();
      notifyListeners();
    } catch (e) {
      print('Error loading trips: $e');
      throw e; // Handle errors as needed
    }
  }

  // Add a new trip
  Future<void> addTrip(Trip trip) async {
    try {
      await _firebaseService.addTrip(trip);
      _trips.add(trip); // Add the new trip to the list
      notifyListeners();
    } catch (e) {
      print('Error adding trip: $e');
      throw e; // Handle errors as needed
    }
  }

  // Update an existing trip
  Future<void> updateTrip(Trip trip) async {
    try {
      await _firebaseService.updateTrip(trip);
      final index = _trips.indexWhere((t) => t.id == trip.id);
      if (index != -1) {
        _trips[index] = trip; // Update the trip in the list
        notifyListeners();
      }
    } catch (e) {
      print('Error updating trip: $e');
      throw e; // Handle errors as needed
    }
  }

  // Delete a trip
  Future<void> deleteTrip(String tripId) async {
    try {
      await _firebaseService.deleteTrip(tripId);
      _trips.removeWhere((trip) => trip.id == tripId); // Remove the trip from the list
      notifyListeners();
    } catch (e) {
      print('Error deleting trip: $e');
      throw e; // Handle errors as needed
    }
  }

  // Share a trip with a user
  Future<void> shareTrip(String tripId, String email, String permission) async {
    try {
      await _firebaseService.shareTrip(tripId, email, permission);
      // Optionally update local state or notify users
    } catch (e) {
      print('Error sharing trip: $e');
      throw e; // Handle errors as needed
    }
  }

  // Get users who have access to the trip
  Future<List<Map<String, dynamic>>> getSharedUsers(String tripId) async {
    try {
      return await _firebaseService.getSharedUsers(tripId);
    } catch (e) {
      print('Error getting shared users: $e');
      throw e; // Handle errors as needed
    }
  }

  // Remove a user from the shared list
  Future<void> removeSharedUser(String tripId, String email) async {
    try {
      await _firebaseService.removeSharedUser(tripId, email);
      // Optionally update local state or notify users
    } catch (e) {
      print('Error removing shared user: $e');
      throw e; // Handle errors as needed
    }
  }
}
