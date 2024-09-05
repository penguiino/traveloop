import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/trip.dart';
import '../models/user.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Save a user to Firestore
  Future<void> saveUser(AppUser user) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }

  // Get a user by their ID
  Future<AppUser?> getUserById(String id) async {
    try {
      final doc = await _firestore.collection('users').doc(id).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          return AppUser.fromJson(data);
        } else {
          throw Exception('User data is null');
        }
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  Future<void> addTrip(Trip trip) async {
    try {
      final userId = getCurrentUser()!.uid;
      print('Adding trip for user: $userId');
      await _firestore.collection('users').doc(userId).collection('trips').add(trip.toMap());
      print('Trip added successfully');
    } catch (e) {
      print('Error adding trip: $e');
    }
  }

  Future<List<Trip>> getTrips() async {
    print('getTrips() method called');
    try {
      final userId = getCurrentUser()!.uid;
      print('Fetching trips for user: $userId');
      final tripSnapshots = await _firestore.collection('users').doc(userId).collection('trips').get();
      final trips = tripSnapshots.docs.map((doc) => Trip.fromMap(doc.data() as Map<String, dynamic>)).toList();
      print('Trips fetched: ${trips.length}');
      return trips;
    } catch (e) {
      print('Error fetching trips: $e');
      return [];
    }
  }

  Future<Trip> getTrip(String tripId) async {
    try {
      final doc = await _firestore.collection('users').doc(getCurrentUser()!.uid).collection('trips').doc(tripId).get();
      print('Trip fetched successfully');
      return Trip.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      print('Error fetching trip: $e');
      rethrow; // or return a default Trip object if applicable
    }
  }


  // Update a trip
  Future<void> updateTrip(Trip trip) async {
    final userId = getCurrentUser()!.uid;
    await _firestore.collection('users').doc(userId).collection('trips').doc(trip.id).update(trip.toMap());
  }

  // Delete a trip
  Future<void> deleteTrip(String tripId) async {
    final userId = getCurrentUser()!.uid;
    await _firestore.collection('users').doc(userId).collection('trips').doc(tripId).delete();
  }

  // Share a trip with a user
  Future<void> shareTrip(String tripId, String email, String permission) async {
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

  // Get shared users for a trip
  Future<List<Map<String, dynamic>>> getSharedUsers(String tripId) async {
    final sharedWithSnapshot = await _firestore.collection('trips').doc(tripId).collection('sharedWith').get();
    return sharedWithSnapshot.docs.map((doc) => {
      'email': doc.id, // Assuming the document ID is the user's email
      'permission': doc.data()['permission']
    }).toList();
  }

  Future<void> removeSharedUser(String tripId, String email) async {
    final currentUser = getCurrentUser();
    if (currentUser == null) throw Exception('No user logged in');

    final userQuery = await _firestore.collection('users').where('email', isEqualTo: email).get();
    if (userQuery.docs.isEmpty) throw Exception('User not found');

    final userId = userQuery.docs.first.id;
    await _firestore.collection('trips').doc(tripId).collection('sharedWith').doc(userId).delete();
  }


  // Fetch trips for a specific user
  Future<List<Trip>> getTripsByUser(String userId) async {
    final snapshot = await _firestore.collection('users').doc(userId).collection('trips').get();
    return snapshot.docs.map((doc) => Trip.fromMap(doc.data())).toList();
  }
}
