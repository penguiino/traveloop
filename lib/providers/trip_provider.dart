import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../services/trip_service.dart';

class TripProvider with ChangeNotifier {
  List<Trip> _trips = [];
  Trip? _selectedTrip;

  List<Trip> get trips => _trips;
  Trip? get selectedTrip => _selectedTrip;

  // Method to load trips for the current user
  Future<void> loadTrips(String userId) async {
    _trips = await TripService.getTripsByUser(userId);
    notifyListeners();
  }

  // Method to add a new trip
  Future<void> addTrip(Trip trip) async {
    await TripService.addTrip(trip);
    _trips.add(trip);
    notifyListeners();
  }

  // Method to update an existing trip
  Future<void> updateTrip(Trip updatedTrip) async {
    await TripService.updateTrip(updatedTrip);
    int index = _trips.indexWhere((trip) => trip.id == updatedTrip.id);
    if (index != -1) {
      _trips[index] = updatedTrip;
      notifyListeners();
    }
  }

  // Method to remove a trip
  Future<void> removeTrip(String tripId) async {
    await TripService.removeTrip(tripId);
    _trips.removeWhere((trip) => trip.id == tripId);
    notifyListeners();
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
