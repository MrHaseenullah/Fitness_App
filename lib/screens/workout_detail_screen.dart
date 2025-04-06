import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart' hide AppColors;
import '../providers/workout_provider.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final String title;
  final String exercises;
  final String duration;
  final Color color;
  final String imagePath;

  const WorkoutDetailScreen({
    Key? key,
    required this.title,
    required this.exercises,
    required this.duration,
    required this.color,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: color,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(color: Colors.black.withAlpha(100), blurRadius: 2),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Image
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: color.withAlpha(100),
                        child: Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                          size: 50,
                        ),
                      );
                    },
                  ),
                  // Gradient overlay for better text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(179),
                        ],
                        stops: const [0.7, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Workout Info
                  Row(
                    children: [
                      _buildInfoCard(
                        context,
                        icon: Icons.fitness_center,
                        title: exercises,
                        subtitle: 'Exercises',
                      ),
                      const SizedBox(width: AppConstants.spacingM),
                      _buildInfoCard(
                        context,
                        icon: Icons.timer,
                        title: duration,
                        subtitle: 'Duration',
                      ),
                      const SizedBox(width: AppConstants.spacingM),
                      _buildInfoCard(
                        context,
                        icon: Icons.local_fire_department,
                        title: '320',
                        subtitle: 'Calories',
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingXL),

                  // Description
                  Text(
                    'Description',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : null,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingM),
                  Text(
                    _getWorkoutDescription(title),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color:
                          isDarkMode
                              ? Colors.white.withAlpha(220)
                              : theme.colorScheme.onSurface.withAlpha(220),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingXL),

                  // Exercises
                  Text(
                    'Exercises',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : null,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingM),

                  // Exercise List
                  ...getExercisesForWorkout(
                    title,
                  ).map((exercise) => _buildExerciseItem(context, exercise)),

                  const SizedBox(height: AppConstants.spacingXL),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Enroll in the workout
            final workoutProvider = Provider.of<WorkoutProvider>(
              context,
              listen: false,
            );
            workoutProvider.enrollWorkout(
              title: title,
              exercises: exercises,
              duration: duration,
              color: color,
              imagePath: imagePath,
            );

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Workout enrolled successfully!')),
            );

            // Navigate back to the workout screen
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.spacingM,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
            ),
          ),
          child: const Text(
            'Start Workout',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingM),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          border:
              isDarkMode
                  ? Border.all(color: Colors.grey[700]!, width: 1)
                  : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(isDarkMode ? 30 : 10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: AppConstants.spacingS),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : null,
              ),
            ),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color:
                    isDarkMode
                        ? Colors.white.withAlpha(179)
                        : theme.colorScheme.onSurface.withAlpha(179),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseItem(
    BuildContext context,
    Map<String, dynamic> exercise,
  ) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        border:
            isDarkMode ? Border.all(color: Colors.grey[700]!, width: 1) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDarkMode ? 30 : 10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppConstants.spacingM),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withAlpha(40),
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          ),
          child: Icon(Icons.fitness_center, color: color),
        ),
        title: Text(
          exercise['name'],
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : null,
          ),
        ),
        subtitle: Text(
          exercise['sets'],
          style: theme.textTheme.bodySmall?.copyWith(
            color:
                isDarkMode
                    ? Colors.white.withAlpha(179)
                    : theme.colorScheme.onSurface.withAlpha(179),
          ),
        ),
        trailing: Text(
          exercise['duration'],
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ),
    );
  }

  String _getWorkoutDescription(String workoutTitle) {
    switch (workoutTitle.toLowerCase()) {
      case 'cardio':
        return 'This high-intensity cardio workout is designed to boost your heart rate, burn calories, and improve your cardiovascular health. Perfect for all fitness levels, this routine can be modified to match your intensity preferences. The workout includes a mix of aerobic exercises that will help you build endurance and stamina while torching calories.';
      case 'arms':
        return 'This comprehensive arms workout targets your biceps, triceps, and shoulders to help you build strength and definition. The routine includes a variety of exercises using both bodyweight and free weights to ensure all muscle groups are properly engaged. Perfect for those looking to tone and strengthen your upper body.';
      case 'yoga':
        return 'This yoga session focuses on improving flexibility, balance, and mental clarity. Through a series of poses and controlled breathing, you will strengthen your core, increase your range of motion, and reduce stress. Suitable for beginners and experienced practitioners alike, this routine can be adapted to your comfort level.';
      case 'pilates':
        return 'This Pilates workout concentrates on developing core strength, proper posture, and muscular balance. With an emphasis on controlled, precise movements and proper breathing, this routine will help improve your flexibility, body awareness, and overall strength without adding bulk.';
      case 'full body':
        return 'This comprehensive full-body workout targets all major muscle groups for a balanced training session. Combining strength, mobility, and cardio elements, this routine ensures you get a complete workout in a single session. Perfect for those looking to maximize efficiency and overall fitness.';
      case 'stretching':
        return 'This stretching routine is designed to improve flexibility, increase range of motion, and reduce muscle tension. Taking time to properly stretch helps prevent injuries, improves posture, and enhances recovery. This session is perfect for both active recovery days and as a complement to more intense workouts.';
      default:
        return 'This workout is designed to help you achieve your fitness goals with a balanced approach to exercise. Follow along with the exercises listed below, paying careful attention to form and technique. Adjust weights and intensity as needed based on your fitness level.';
    }
  }

  List<Map<String, dynamic>> getExercisesForWorkout(String workoutTitle) {
    switch (workoutTitle.toLowerCase()) {
      case 'cardio':
        return [
          {'name': 'Jumping Jacks', 'sets': '3 sets', 'duration': '1 min'},
          {'name': 'High Knees', 'sets': '3 sets', 'duration': '45 sec'},
          {'name': 'Burpees', 'sets': '3 sets', 'duration': '30 sec'},
          {'name': 'Mountain Climbers', 'sets': '3 sets', 'duration': '45 sec'},
          {'name': 'Jump Rope', 'sets': '3 sets', 'duration': '1 min'},
          {'name': 'Squat Jumps', 'sets': '3 sets', 'duration': '45 sec'},
          {'name': 'Lateral Shuffles', 'sets': '3 sets', 'duration': '30 sec'},
          {'name': 'Plank Jacks', 'sets': '3 sets', 'duration': '30 sec'},
          {'name': 'Speed Skaters', 'sets': '3 sets', 'duration': '45 sec'},
          {'name': 'Jumping Lunges', 'sets': '3 sets', 'duration': '45 sec'},
        ];
      case 'arms':
        return [
          {
            'name': 'Bicep Curls',
            'sets': '3 sets of 12 reps',
            'duration': '45 sec',
          },
          {
            'name': 'Tricep Dips',
            'sets': '3 sets of 15 reps',
            'duration': '45 sec',
          },
          {
            'name': 'Push-Ups',
            'sets': '3 sets of 10 reps',
            'duration': '1 min',
          },
          {
            'name': 'Hammer Curls',
            'sets': '3 sets of 12 reps',
            'duration': '45 sec',
          },
          {
            'name': 'Overhead Tricep Extensions',
            'sets': '3 sets of 12 reps',
            'duration': '45 sec',
          },
          {
            'name': 'Lateral Raises',
            'sets': '3 sets of 12 reps',
            'duration': '45 sec',
          },
        ];
      default:
        return [
          {
            'name': 'Exercise 1',
            'sets': '3 sets of 12 reps',
            'duration': '45 sec',
          },
          {
            'name': 'Exercise 2',
            'sets': '3 sets of 15 reps',
            'duration': '45 sec',
          },
          {
            'name': 'Exercise 3',
            'sets': '3 sets of 10 reps',
            'duration': '1 min',
          },
          {
            'name': 'Exercise 4',
            'sets': '3 sets of 12 reps',
            'duration': '45 sec',
          },
          {
            'name': 'Exercise 5',
            'sets': '3 sets of 12 reps',
            'duration': '45 sec',
          },
        ];
    }
  }
}
