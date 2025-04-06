import 'package:flutter/material.dart';

class Exercise {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final Duration duration;
  final int repetitions;
  final int sets;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.repetitions,
    required this.sets,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      duration: Duration(seconds: json['durationInSeconds']),
      repetitions: json['repetitions'],
      sets: json['sets'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'durationInSeconds': duration.inSeconds,
      'repetitions': repetitions,
      'sets': sets,
    };
  }
}

class Workout {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<Exercise> exercises;
  final WorkoutCategory category;
  final WorkoutLevel level;
  final Duration totalDuration;
  final Color color;

  Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.exercises,
    required this.category,
    required this.level,
    required this.totalDuration,
    required this.color,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e))
          .toList(),
      category: WorkoutCategory.values.firstWhere(
          (e) => e.toString() == 'WorkoutCategory.${json['category']}'),
      level: WorkoutLevel.values.firstWhere(
          (e) => e.toString() == 'WorkoutLevel.${json['level']}'),
      totalDuration: Duration(seconds: json['totalDurationInSeconds']),
      color: Color(json['color']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'category': category.toString().split('.').last,
      'level': level.toString().split('.').last,
      'totalDurationInSeconds': totalDuration.inSeconds,
      'color': color.value,
    };
  }

  String get formattedDuration {
    final minutes = totalDuration.inMinutes;
    return '$minutes Minutes';
  }

  String get exerciseCount {
    return '${exercises.length} Exercises';
  }
}

enum WorkoutCategory {
  yoga,
  cardio,
  strength,
  hiit,
  pilates,
  stretching,
  fullBody
}

enum WorkoutLevel {
  beginner,
  intermediate,
  advanced
}

class WorkoutProgress {
  final String id;
  final String workoutId;
  final String userId;
  final DateTime date;
  final Duration duration;
  final bool completed;

  WorkoutProgress({
    required this.id,
    required this.workoutId,
    required this.userId,
    required this.date,
    required this.duration,
    required this.completed,
  });

  factory WorkoutProgress.fromJson(Map<String, dynamic> json) {
    return WorkoutProgress(
      id: json['id'],
      workoutId: json['workoutId'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      duration: Duration(seconds: json['durationInSeconds']),
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workoutId': workoutId,
      'userId': userId,
      'date': date.toIso8601String(),
      'durationInSeconds': duration.inSeconds,
      'completed': completed,
    };
  }
}
