enum ExerciseType {
  repetition,  // For exercises counted in reps (e.g., push-ups, squats)
  duration     // For exercises measured in time (e.g., plank, running)
}

class Exercise {
  final String name;
  final ExerciseType type;
  final int target;  // Target reps or seconds
  final String? description;
  int progress;      // Current progress (reps completed or seconds elapsed)

  Exercise({
    required this.name,
    required this.type,
    required this.target,
    this.description,
    this.progress = 0,
  });

  // Create a copy of this exercise with updated properties
  Exercise copyWith({
    String? name,
    ExerciseType? type,
    int? target,
    String? description,
    int? progress,
  }) {
    return Exercise(
      name: name ?? this.name,
      type: type ?? this.type,
      target: target ?? this.target,
      description: description ?? this.description,
      progress: progress ?? this.progress,
    );
  }
}
