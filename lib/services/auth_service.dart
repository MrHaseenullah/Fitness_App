import 'dart:async';
import '../models/user_model.dart';

class AuthService {
  // Simulate a database of users
  final List<User> _users = [
    // Add a default user for testing
    User(
      id: '1',
      username: 'testuser',
      email: 'test@example.com',
      fullName: 'Test User',
      createdAt: DateTime.now(),
    ),
  ];
  User? _currentUser;

  // Stream controller for authentication state changes
  final StreamController<User?> _authStateController =
      StreamController<User?>.broadcast();
  Stream<User?> get authStateChanges => _authStateController.stream;

  // Get current user
  User? get currentUser => _currentUser;

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Find user with matching email (in a real app, you'd check password hash)
    try {
      final user = _users.firstWhere(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
      );
      _currentUser = user;
      _authStateController.add(user);
      return user;
    } catch (e) {
      // User not found
      return null;
    }
  }

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(
    String username,
    String email,
    String password,
    String fullName,
  ) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Check if email already exists
      final existingEmail = _users.any(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
      );
      if (existingEmail) {
        throw Exception('Email already in use');
      }

      // Check if username already exists
      final existingUsername = _users.any(
        (user) => user.username.toLowerCase() == username.toLowerCase(),
      );
      if (existingUsername) {
        throw Exception('Username already taken');
      }

      // Create new user
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: username,
        email: email,
        fullName: fullName,
        createdAt: DateTime.now(),
      );

      _users.add(newUser);
      _currentUser = newUser;
      _authStateController.add(newUser);
      return newUser;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    _currentUser = null;
    _authStateController.add(null);
  }

  // Sign in with Google (mock)
  Future<User?> signInWithGoogle() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final newUser = User(
        id: 'google-${DateTime.now().millisecondsSinceEpoch}',
        username: 'Google User',
        email: 'google_user@example.com',
        fullName: 'Google User',
        profileImageUrl: 'https://via.placeholder.com/150',
        createdAt: DateTime.now(),
      );

      _currentUser = newUser;
      _authStateController.add(newUser);
      return newUser;
    } catch (e) {
      // Handle any errors
      return null;
    }
  }

  // Update user profile
  Future<User?> updateUserProfile({
    required String userId,
    String? fullName,
    String? profileImageUrl,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    try {
      // Find user by ID
      final index = _users.indexWhere((user) => user.id == userId);
      if (index == -1) return null;

      // Update user
      final updatedUser = _users[index].copyWith(
        fullName: fullName,
        profileImageUrl: profileImageUrl,
      );

      // Replace in list
      _users[index] = updatedUser;

      // Update current user if it's the same user
      if (_currentUser?.id == userId) {
        _currentUser = updatedUser;
        _authStateController.add(updatedUser);
      }

      return updatedUser;
    } catch (e) {
      return null;
    }
  }

  // Dispose resources
  void dispose() {
    _authStateController.close();
  }
}
