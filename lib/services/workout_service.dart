import 'dart:async';
import 'package:flutter/material.dart';
import '../models/workout_model.dart';

class WorkoutService {
  // Simulate a database of workouts
  final List<Workout> _workouts = [
    Workout(
      id: '1',
      name: 'Morning Yoga',
      description: 'Start your day with a refreshing yoga session to energize your body and mind.',
      imageUrl: 'assets/images/yoga.jpg',
      exercises: [
        Exercise(
          id: '1',
          name: 'Downward Dog',
          description: 'A yoga pose that stretches and strengthens the whole body.',
          imageUrl: 'assets/images/downward_dog.jpg',
          duration: const Duration(seconds: 60),
          repetitions: 1,
          sets: 3,
        ),
        Exercise(
          id: '2',
          name: 'Warrior Pose',
          description: 'A standing yoga pose that improves strength, balance, and focus.',
          imageUrl: 'assets/images/warrior.jpg',
          duration: const Duration(seconds: 45),
          repetitions: 1,
          sets: 2,
        ),
        Exercise(
          id: '3',
          name: 'Tree Pose',
          description: 'A balancing pose that improves focus and stability.',
          imageUrl: 'assets/images/tree_pose.jpg',
          duration: const Duration(seconds: 30),
          repetitions: 1,
          sets: 2,
        ),
      ],
      category: WorkoutCategory.yoga,
      level: WorkoutLevel.beginner,
      totalDuration: const Duration(minutes: 15),
      color: Colors.blue.shade200,
    ),
    Workout(
      id: '2',
      name: 'HIIT Cardio',
      description: 'High-intensity interval training to boost your metabolism and burn calories.',
      imageUrl: 'assets/images/hiit.jpg',
      exercises: [
        Exercise(
          id: '4',
          name: 'Jumping Jacks',
          description: 'A classic cardio exercise that works your whole body.',
          imageUrl: 'assets/images/jumping_jacks.jpg',
          duration: const Duration(seconds: 30),
          repetitions: 20,
          sets: 3,
        ),
        Exercise(
          id: '5',
          name: 'Mountain Climbers',
          description: 'A dynamic exercise that targets your core and cardiovascular system.',
          imageUrl: 'assets/images/mountain_climbers.jpg',
          duration: const Duration(seconds: 30),
          repetitions: 15,
          sets: 3,
        ),
        Exercise(
          id: '6',
          name: 'Burpees',
          description: 'A full-body exercise that builds strength and endurance.',
          imageUrl: 'assets/images/burpees.jpg',
          duration: const Duration(seconds: 30),
          repetitions: 10,
          sets: 3,
        ),
      ],
      category: WorkoutCategory.hiit,
      level: WorkoutLevel.intermediate,
      totalDuration: const Duration(minutes: 20),
      color: Colors.red.shade200,
    ),
    Workout(
      id: '3',
      name: 'Full Body Strength',
      description: 'Build strength and muscle with this comprehensive full-body workout.',
      imageUrl: 'assets/images/strength.jpg',
      exercises: [
        Exercise(
          id: '7',
          name: 'Push-ups',
          description: 'A classic exercise that targets your chest, shoulders, and triceps.',
          imageUrl: 'assets/images/pushups.jpg',
          duration: const Duration(seconds: 0),
          repetitions: 12,
          sets: 3,
        ),
        Exercise(
          id: '8',
          name: 'Squats',
          description: 'A lower body exercise that targets your quads, hamstrings, and glutes.',
          imageUrl: 'assets/images/squats.jpg',
          duration: const Duration(seconds: 0),
          repetitions: 15,
          sets: 3,
        ),
        Exercise(
          id: '9',
          name: 'Plank',
          description: 'A core exercise that improves stability and posture.',
          imageUrl: 'assets/images/plank.jpg',
          duration: const Duration(seconds: 30),
          repetitions: 1,
          sets: 3,
        ),
      ],
      category: WorkoutCategory.strength,
      level: WorkoutLevel.intermediate,
      totalDuration: const Duration(minutes: 30),
      color: Colors.green.shade200,
    ),
    Workout(
      id: '4',
      name: 'Pilates Core',
      description: 'Strengthen your core and improve flexibility with this Pilates workout.',
      imageUrl: 'assets/images/pilates.jpg',
      exercises: [
        Exercise(
          id: '10',
          name: 'The Hundred',
          description: 'A Pilates exercise that warms up the body and engages the core.',
          imageUrl: 'assets/images/hundred.jpg',
          duration: const Duration(seconds: 60),
          repetitions: 1,
          sets: 1,
        ),
        Exercise(
          id: '11',
          name: 'Roll Up',
          description: 'A Pilates exercise that strengthens the abdominals and improves spinal flexibility.',
          imageUrl: 'assets/images/rollup.jpg',
          duration: const Duration(seconds: 0),
          repetitions: 10,
          sets: 2,
        ),
        Exercise(
          id: '12',
          name: 'Leg Circles',
          description: 'A Pilates exercise that improves hip mobility and core stability.',
          imageUrl: 'assets/images/leg_circles.jpg',
          duration: const Duration(seconds: 0),
          repetitions: 10,
          sets: 2,
        ),
      ],
      category: WorkoutCategory.pilates,
      level: WorkoutLevel.beginner,
      totalDuration: const Duration(minutes: 25),
      color: Colors.purple.shade200,
    ),
    Workout(
      id: '5',
      name: 'Stretching Routine',
      description: 'Improve flexibility and reduce muscle tension with this stretching routine.',
      imageUrl: 'assets/images/stretching.jpg',
      exercises: [
        Exercise(
          id: '13',
          name: 'Hamstring Stretch',
          description: 'A stretch that targets the back of your legs.',
          imageUrl: 'assets/images/hamstring_stretch.jpg',
          duration: const Duration(seconds: 30),
          repetitions: 1,
          sets: 2,
        ),
        Exercise(
          id: '14',
          name: 'Shoulder Stretch',
          description: 'A stretch that relieves tension in the shoulders and upper back.',
          imageUrl: 'assets/images/shoulder_stretch.jpg',
          duration: const Duration(seconds: 30),
          repetitions: 1,
          sets: 2,
        ),
        Exercise(
          id: '15',
          name: 'Hip Flexor Stretch',
          description: 'A stretch that targets the front of your hips.',
          imageUrl: 'assets/images/hip_flexor_stretch.jpg',
          duration: const Duration(seconds: 30),
          repetitions: 1,
          sets: 2,
        ),
      ],
      category: WorkoutCategory.stretching,
      level: WorkoutLevel.beginner,
      totalDuration: const Duration(minutes: 15),
      color: Colors.orange.shade200,
    ),
  ];

  // Get all workouts
  Future<List<Workout>> getWorkouts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _workouts;
  }

  // Get workout by ID
  Future<Workout?> getWorkoutById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _workouts.firstWhere((workout) => workout.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get workouts by category
  Future<List<Workout>> getWorkoutsByCategory(WorkoutCategory category) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _workouts.where((workout) => workout.category == category).toList();
  }

  // Track workout progress
  Future<WorkoutProgress> trackWorkoutProgress(
      String userId, String workoutId, Duration duration, bool completed) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final progress = WorkoutProgress(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      workoutId: workoutId,
      userId: userId,
      date: DateTime.now(),
      duration: duration,
      completed: completed,
    );
    
    return progress;
  }
}
