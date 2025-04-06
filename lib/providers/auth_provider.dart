import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;
  String? _error;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  // Constructor
  AuthProvider() {
    // Listen to auth state changes
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Sign in with email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // For demo purposes, allow any email/password combination
      // In a real app, you would validate against a backend
      if (email.isNotEmpty && password.isNotEmpty) {
        // Check if user exists in the mock database
        final user = await _authService.signInWithEmailAndPassword(
          email,
          password,
        );

        if (user == null) {
          // For demo, create a new user if not found
          final newUser = User(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            username: email.split('@')[0],
            email: email,
            fullName: email.split('@')[0],
            createdAt: DateTime.now(),
          );

          _user = newUser;
          _isLoading = false;
          notifyListeners();
          return true;
        }

        _user = user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        _error = 'Email and password cannot be empty';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Sign up with email and password
  Future<bool> signUpWithEmailAndPassword(
    String username,
    String email,
    String password,
    String fullName,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // For demo purposes, allow any valid input
      // In a real app, you would validate against a backend
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          fullName.isNotEmpty) {
        // Create a new user directly
        final newUser = User(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          username: username,
          email: email,
          fullName: fullName,
          createdAt: DateTime.now(),
        );

        _user = newUser;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        _error = 'All fields are required';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      // Extract the error message from the exception
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception:')) {
        errorMessage = errorMessage.split('Exception:')[1].trim();
      }
      _error = errorMessage;
      notifyListeners();
      return false;
    }
  }

  // Sign in with Google
  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = await _authService.signInWithGoogle();
      _isLoading = false;

      if (user == null) {
        _error = 'Google sign in failed';
        notifyListeners();
        return false;
      }

      _user = user;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Sign out
  Future<bool> signOut() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.signOut();
      _isLoading = false;
      _user = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Update user profile
  Future<bool> updateUserProfile({
    required String fullName,
    String? profileImageUrl,
  }) async {
    if (_user == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedUser = await _authService.updateUserProfile(
        userId: _user!.id,
        fullName: fullName,
        profileImageUrl: profileImageUrl,
      );

      _isLoading = false;

      if (updatedUser == null) {
        _error = 'Failed to update profile';
        notifyListeners();
        return false;
      }

      _user = updatedUser;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }
}
