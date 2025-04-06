import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../services/workout_service.dart';

class EnrolledWorkout {
  final String id;
  final String title;
  final String exercises;
  final String duration;
  final Color color;
  final String imagePath;
  final double progress;
  final DateTime enrolledDate;

  EnrolledWorkout({
    required this.id,
    required this.title,
    required this.exercises,
    required this.duration,
    required this.color,
    required this.imagePath,
    this.progress = 0.0,
    required this.enrolledDate,
  });
}

class WorkoutProvider extends ChangeNotifier {
  final WorkoutService _workoutService = WorkoutService();
  List<Workout> _workouts = [];
  Workout? _selectedWorkout;
  bool _isLoading = false;
  String? _error;
  List<WorkoutProgress> _workoutProgress = [];

  // Enrolled workouts
  final List<EnrolledWorkout> _enrolledWorkouts = [];

  // Getters
  List<Workout> get workouts => _workouts;
  Workout? get selectedWorkout => _selectedWorkout;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<WorkoutProgress> get workoutProgress => _workoutProgress;

  // Enrolled workouts getters
  List<EnrolledWorkout> get enrolledWorkouts => _enrolledWorkouts;
  bool get hasEnrolledWorkouts => _enrolledWorkouts.isNotEmpty;

  // Load all workouts
  Future<void> loadWorkouts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _workouts = await _workoutService.getWorkouts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to load workouts: ${e.toString()}';
      notifyListeners();
    }
  }

  // Get workout by ID
  Future<void> getWorkoutById(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedWorkout = await _workoutService.getWorkoutById(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to load workout: ${e.toString()}';
      notifyListeners();
    }
  }

  // Get workouts by category
  Future<List<Workout>> getWorkoutsByCategory(WorkoutCategory category) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final categoryWorkouts = await _workoutService.getWorkoutsByCategory(
        category,
      );
      _isLoading = false;
      notifyListeners();
      return categoryWorkouts;
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to load workouts: ${e.toString()}';
      notifyListeners();
      return [];
    }
  }

  // Track workout progress
  Future<void> trackWorkoutProgress(
    String userId,
    String workoutId,
    Duration duration,
    bool completed,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final progress = await _workoutService.trackWorkoutProgress(
        userId,
        workoutId,
        duration,
        completed,
      );
      _workoutProgress.add(progress);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to track workout progress: ${e.toString()}';
      notifyListeners();
    }
  }

  // Get completed workouts count
  int getCompletedWorkoutsCount() {
    return _workoutProgress.where((progress) => progress.completed).length;
  }

  // Get in-progress workouts count
  int getInProgressWorkoutsCount() {
    return _workoutProgress.where((progress) => !progress.completed).length;
  }

  // Get total time spent on workouts
  Duration getTotalTimeSpent() {
    return _workoutProgress.fold(
      Duration.zero,
      (total, progress) => total + progress.duration,
    );
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Clear selected workout
  void clearSelectedWorkout() {
    _selectedWorkout = null;
    notifyListeners();
  }

  // Enroll in a workout
  void enrollWorkout({
    required String title,
    required String exercises,
    required String duration,
    required Color color,
    required String imagePath,
  }) {
    // Check if workout is already enrolled
    final existingIndex = _enrolledWorkouts.indexWhere(
      (workout) => workout.title == title,
    );

    if (existingIndex >= 0) {
      // Workout already enrolled, don't add it again
      return;
    }

    final newWorkout = EnrolledWorkout(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      exercises: exercises,
      duration: duration,
      color: color,
      imagePath: imagePath,
      enrolledDate: DateTime.now(),
    );

    _enrolledWorkouts.add(newWorkout);
    notifyListeners();
  }

  // Update workout progress
  void updateWorkoutProgress(String id, double progress) {
    final index = _enrolledWorkouts.indexWhere((workout) => workout.id == id);
    if (index >= 0) {
      final workout = _enrolledWorkouts[index];
      final updatedWorkout = EnrolledWorkout(
        id: workout.id,
        title: workout.title,
        exercises: workout.exercises,
        duration: workout.duration,
        color: workout.color,
        imagePath: workout.imagePath,
        progress: progress,
        enrolledDate: workout.enrolledDate,
      );

      _enrolledWorkouts[index] = updatedWorkout;
      notifyListeners();
    }
  }

  // Remove enrolled workout
  void removeEnrolledWorkout(String id) {
    _enrolledWorkouts.removeWhere((workout) => workout.id == id);
    notifyListeners();
  }
}
