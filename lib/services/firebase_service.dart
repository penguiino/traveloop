import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/trip.dart';
import '../models/trip_container.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Add a new trip
  Future<void> addTrip(Trip trip) async {
    final userId = getCurrentUser()!.uid;
    await _firestore.collection('users').doc(userId).collection('trips').add({
      'name': trip.name,
      'startDate': trip.startDate.toIso8601String(),
      'endDate': trip.endDate.toIso8601String(),
      'containers': trip.containers.map((container) => {
        'title': container.title,
        'type': container.type,
        'details': container.details,
        'subContainers': container.subContainers.map((sub) => {
          'title': sub.title,
          'type': sub.type,
          'details': sub.details,
        }).toList(),
      }).toList(),
    });
  }

  // Get a list of trips for the current user
  Future<List<Trip>> getTrips() async {
    final userId = getCurrentUser()!.uid;
    final tripSnapshots = await _firestore.collection('users').doc(userId).collection('trips').get();
    return tripSnapshots.docs.map((doc) {
      final data = doc.data();
      return Trip(
        id: doc.id,
        name: data['name'],
        startDate: DateTime.parse(data['startDate']),
        endDate: DateTime.parse(data['endDate']),
        containers: List<TripContainer>.from(data['containers'].map((item) => TripContainer.fromMap(item))),
      );
    }).toList();
  }

  // Get a single trip by ID
  Future<Trip> getTrip(String tripId) async {
    final doc = await _firestore.collection('users').doc(getCurrentUser()!.uid).collection('trips').doc(tripId).get();
    final data = doc.data()!;
    return Trip(
      id: doc.id,
      name: data['name'],
      startDate: DateTime.parse(data['startDate']),
      endDate: DateTime.parse(data['endDate']),
      containers: List<TripContainer>.from(data['containers'].map((item) => TripContainer.fromMap(item))),
    );
  }

  // Update a trip
  Future<void> updateTrip(Trip trip) async {
    final userId = getCurrentUser()!.uid;
    await _firestore.collection('users').doc(userId).collection('trips').doc(trip.id).update({
      'name': trip.name,
      'startDate': trip.startDate.toIso8601String(),
      'endDate': trip.endDate.toIso8601String(),
      'containers': trip.containers.map((container) => {
        'title': container.title,
        'type': container.type,
        'details': container.details,
        'subContainers': container.subContainers.map((sub) => {
          'title': sub.title,
          'type': sub.type,
          'details': sub.details,
        }).toList(),
      }).toList(),
    });
  }

  // Delete a trip
  Future<void> deleteTrip(String tripId) async {
    final userId = getCurrentUser()!.uid;
    await _firestore.collection('users').doc(userId).collection('trips').doc(tripId).delete();
  }

  // Share a trip with a user
  Future<void> shareTrip(String tripId, String email, String permission) async {
    final userId = getCurrentUser()!.uid;
    final userDoc = await _firestore.collection('users').where('email', isEqualTo: email).get();
    if (userDoc.docs.isNotEmpty) {
      final sharedUserId = userDoc.docs.first.id;
      await _firestore.collection('trips').doc(tripId).collection('sharedWith').doc(sharedUserId).set({
        'permission': permission,
      });
    } else {
      throw Exception('User not found');
    }
  }

  // Get users who have access to the trip
  Future<List<Map<String, dynamic>>> getSharedUsers(String tripId) async {
    final sharedUsersSnapshot = await _firestore.collection('trips').doc(tripId).collection('sharedWith').get();
    final users = await Future.wait(sharedUsersSnapshot.docs.map((doc) async {
      final userDoc = await _firestore.collection('users').doc(doc.id).get();
      return {
        'email': userDoc.data()?['email'],
        'permission': doc.data()['permission'],
      };
    }));
    return users;
  }

  // Remove a user from the shared list
  Future<void> removeSharedUser(String tripId, String email) async {
    final userDoc = await _firestore.collection('users').where('email', isEqualTo: email).get();
    if (userDoc.docs.isNotEmpty) {
      final sharedUserId = userDoc.docs.first.id;
      await _firestore.collection('trips').doc(tripId).collection('sharedWith').doc(sharedUserId).delete();
    } else {
      throw Exception('User not found');
    }
  }
}
