import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../services/trip_service.dart';

class TripProvider with ChangeNotifier {
  final TripService _tripService = TripService(); // Create an instance of TripService
  List<Trip> _trips = [];
  Trip? _selectedTrip;

  List<Trip> get trips => _trips;
  Trip? get selectedTrip => _selectedTrip;

  // Method to load trips for the current user
  Future<void> loadTrips(String userId) async {
    try {
      await _tripService.getTripsByUser(userId);
      _trips = _tripService.trips; // Update local state with trips
      notifyListeners();
    } catch (e) {
      print('Error loading trips: $e');
    }
  }

  // Method to add a new trip
  Future<void> addTrip(Trip trip) async {
    try {
      await _tripService.addTrip(trip);
      _trips.add(trip); // Add trip to local state
      notifyListeners();
    } catch (e) {
      print('Error adding trip: $e');
    }
  }

  // Method to update an existing trip
  Future<void> updateTrip(Trip updatedTrip) async {
    try {
      await _tripService.updateTrip(updatedTrip);
      final index = _trips.indexWhere((trip) => trip.id == updatedTrip.id);
      if (index != -1) {
        _trips[index] = updatedTrip; // Update the trip in local state
        notifyListeners();
      }
    } catch (e) {
      print('Error updating trip: $e');
    }
  }

  // Method to remove a trip
  Future<void> removeTrip(String tripId) async {
    try {
      await _tripService.deleteTrip(tripId);
      _trips.removeWhere((trip) => trip.id == tripId); // Remove trip from local state
      notifyListeners();
    } catch (e) {
      print('Error removing trip: $e');
    }
  }

  // Method to select a trip
  void selectTrip(Trip trip) {
    _selectedTrip = trip;
    notifyListeners();
  }

  // Method to clear the selected trip
  void clearSelectedTrip() {
    _selectedTrip = null;
    notifyListeners();
  }
}
