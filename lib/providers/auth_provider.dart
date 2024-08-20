import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import '../services/firebase_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  // Method to initialize the current user
  Future<void> initializeUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      _currentUser = await FirebaseService.getUserById(user.uid);
      notifyListeners();
    }
  }

  // Method to sign in with email and password
  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser =
      await FirebaseService.getUserById(userCredential.user!.uid);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error signing in: $e');
      return false;
    }
  }

  // Method to register a new user
  Future<bool> register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _currentUser = AppUser(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );
      await FirebaseService.saveUser(_currentUser!);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error registering: $e');
      return false;
    }
  }

  // Method to sign out the current user
  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }

  // Method to reset password
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
