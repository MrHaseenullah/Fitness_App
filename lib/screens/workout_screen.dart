import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart' hide AppColors;
import '../providers/workout_provider.dart';
import '../models/exercise_model.dart';
import 'discover_workouts_screen.dart';
import 'progress_screen.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    final hasEnrolledWorkouts = workoutProvider.hasEnrolledWorkouts;
    final enrolledWorkouts = workoutProvider.enrolledWorkouts;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Workouts',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : null,
                ),
              ),
              const SizedBox(height: AppConstants.spacingXL),

              // Workout Categories
              Expanded(
                child:
                    !hasEnrolledWorkouts
                        ? _buildEmptyState(context)
                        : ListView(
                          children: [
                            ...enrolledWorkouts.map(
                              (workout) => Column(
                                children: [
                                  _buildWorkoutCategory(
                                    context,
                                    title: workout.title,
                                    exercises: workout.exercises,
                                    duration: workout.duration,
                                    color: workout.color,
                                    imagePath: workout.imagePath,
                                    progress: workout.progress,
                                  ),
                                  const SizedBox(height: AppConstants.spacingM),
                                ],
                              ),
                            ),
                          ],
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fitness_center,
            size: 80,
            color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
          ),
          const SizedBox(height: AppConstants.spacingL),
          Text(
            'No workouts enrolled yet',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : null,
            ),
          ),
          const SizedBox(height: AppConstants.spacingM),
          Text(
            'Discover and enroll in workouts to start your fitness journey',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color:
                  isDarkMode
                      ? Colors.white.withAlpha(179)
                      : theme.colorScheme.onSurface.withAlpha(179),
            ),
          ),
          const SizedBox(height: AppConstants.spacingXL),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DiscoverWorkoutsScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingXL,
                vertical: AppConstants.spacingM,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
              ),
            ),
            child: const Text(
              'Discover Workouts',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCategory(
    BuildContext context, {
    required String title,
    required String exercises,
    required String duration,
    required Color color,
    required String imagePath,
    required double progress,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Generate sample exercises based on the workout type
    List<Exercise> workoutExercises = _generateExercisesForWorkout(title);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ProgressScreen(
                  workoutTitle: title,
                  workoutColor: color,
                  exercises: workoutExercises,
                ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          border:
              isDarkMode
                  ? Border.all(color: Colors.grey[700]!, width: 1)
                  : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(isDarkMode ? 30 : 10),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workout image and details
            Row(
              children: [
                // Workout image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppConstants.borderRadiusL),
                    bottomLeft: Radius.circular(AppConstants.borderRadiusL),
                  ),
                  child: Image.asset(
                    imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 100,
                        color: color.withAlpha(40),
                        child: Icon(
                          Icons.fitness_center,
                          color: color,
                          size: 35,
                        ),
                      );
                    },
                  ),
                ),

                // Workout details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.spacingM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : null,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingXS),
                        Text(
                          exercises,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color:
                                isDarkMode
                                    ? Colors.white.withAlpha(179)
                                    : theme.colorScheme.onSurface.withAlpha(
                                      179,
                                    ),
                          ),
                        ),
                        Text(
                          duration,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color:
                                isDarkMode
                                    ? Colors.white.withAlpha(179)
                                    : theme.colorScheme.onSurface.withAlpha(
                                      179,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Arrow icon
                Padding(
                  padding: const EdgeInsets.all(AppConstants.spacingM),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color:
                        isDarkMode
                            ? Colors.white.withAlpha(179)
                            : theme.colorScheme.onSurface.withAlpha(179),
                  ),
                ),
              ],
            ),

            // Progress bar
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppConstants.spacingM,
                0,
                AppConstants.spacingM,
                AppConstants.spacingM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppConstants.spacingS),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color:
                              isDarkMode
                                  ? Colors.white.withAlpha(179)
                                  : theme.colorScheme.onSurface.withAlpha(179),
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingXS),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppConstants.borderRadiusS,
                    ),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: color.withAlpha(40),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to generate sample exercises based on workout type
  List<Exercise> _generateExercisesForWorkout(String workoutTitle) {
    // Create different exercises based on the workout type
    switch (workoutTitle.toLowerCase()) {
      case 'cardio':
        return [
          Exercise(
            name: 'Running',
            type: ExerciseType.duration,
            target: 300, // 5 minutes
            description: 'Maintain a steady pace',
          ),
          Exercise(
            name: 'Jumping Jacks',
            type: ExerciseType.repetition,
            target: 50,
            description: 'Keep your arms straight',
          ),
          Exercise(
            name: 'High Knees',
            type: ExerciseType.duration,
            target: 60, // 1 minute
            description: 'Bring knees up to waist level',
          ),
          Exercise(
            name: 'Burpees',
            type: ExerciseType.repetition,
            target: 15,
            description: 'Full body exercise',
          ),
        ];

      case 'arms':
        return [
          Exercise(
            name: 'Push-ups',
            type: ExerciseType.repetition,
            target: 20,
            description: 'Keep your back straight',
          ),
          Exercise(
            name: 'Tricep Dips',
            type: ExerciseType.repetition,
            target: 15,
            description: 'Use a chair or bench',
          ),
          Exercise(
            name: 'Bicep Curls',
            type: ExerciseType.repetition,
            target: 12,
            description: 'Use dumbbells if available',
          ),
          Exercise(
            name: 'Plank',
            type: ExerciseType.duration,
            target: 60, // 1 minute
            description: 'Keep your core tight',
          ),
        ];

      case 'yoga':
        return [
          Exercise(
            name: 'Downward Dog',
            type: ExerciseType.duration,
            target: 45, // 45 seconds
            description: 'Form an inverted V shape',
          ),
          Exercise(
            name: 'Warrior Pose',
            type: ExerciseType.duration,
            target: 60, // 1 minute
            description: 'Keep your front knee at 90 degrees',
          ),
          Exercise(
            name: 'Tree Pose',
            type: ExerciseType.duration,
            target: 30, // 30 seconds
            description: 'Balance on one leg',
          ),
          Exercise(
            name: "Child's Pose",
            type: ExerciseType.duration,
            target: 45, // 45 seconds
            description: 'Relaxation pose',
          ),
        ];

      case 'pilates':
        return [
          Exercise(
            name: 'The Hundred',
            type: ExerciseType.repetition,
            target: 100,
            description: 'Pump arms while holding position',
          ),
          Exercise(
            name: 'Roll Up',
            type: ExerciseType.repetition,
            target: 10,
            description: 'Roll up and down slowly',
          ),
          Exercise(
            name: 'Leg Circles',
            type: ExerciseType.repetition,
            target: 10,
            description: '5 circles in each direction',
          ),
          Exercise(
            name: 'Side Kicks',
            type: ExerciseType.repetition,
            target: 20,
            description: '10 kicks on each side',
          ),
        ];

      default:
        // Generic exercises for any other workout type
        return [
          Exercise(
            name: 'Squats',
            type: ExerciseType.repetition,
            target: 20,
            description: 'Keep your back straight',
          ),
          Exercise(
            name: 'Lunges',
            type: ExerciseType.repetition,
            target: 24,
            description: '12 on each leg',
          ),
          Exercise(
            name: 'Plank',
            type: ExerciseType.duration,
            target: 60, // 1 minute
            description: 'Keep your core tight',
          ),
          Exercise(
            name: 'Mountain Climbers',
            type: ExerciseType.repetition,
            target: 30,
            description: '15 on each leg',
          ),
        ];
    }
  }
}
