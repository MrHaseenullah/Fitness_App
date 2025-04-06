import 'package:flutter/material.dart';
import '../utils/constants.dart' hide AppColors;
import '../utils/colors.dart';
import 'workout_detail_screen.dart';

class DiscoverWorkoutsScreen extends StatelessWidget {
  const DiscoverWorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Discover Workouts',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : null,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingM,
                vertical: AppConstants.spacingS,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                  const SizedBox(width: AppConstants.spacingS),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search workouts',
                        hintStyle: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingXL),

            // Categories
            Text(
              'Categories',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : null,
              ),
            ),
            const SizedBox(height: AppConstants.spacingM),

            // Category grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: AppConstants.spacingM,
              crossAxisSpacing: AppConstants.spacingM,
              childAspectRatio: 1.5,
              children: [
                _buildCategoryCard(
                  context,
                  title: 'Cardio',
                  icon: Icons.directions_run,
                  color: AppColors.cardio,
                ),
                _buildCategoryCard(
                  context,
                  title: 'Strength',
                  icon: Icons.fitness_center,
                  color: AppColors.strength,
                ),
                _buildCategoryCard(
                  context,
                  title: 'Yoga',
                  icon: Icons.self_improvement,
                  color: AppColors.yoga,
                ),
                _buildCategoryCard(
                  context,
                  title: 'Pilates',
                  icon: Icons.accessibility_new,
                  color: AppColors.pilates,
                ),
                _buildCategoryCard(
                  context,
                  title: 'Full Body',
                  icon: Icons.person,
                  color: AppColors.fullBody,
                ),
                _buildCategoryCard(
                  context,
                  title: 'Stretching',
                  icon: Icons.sports_gymnastics,
                  color: AppColors.stretching,
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingXL),

            // Popular workouts
            Text(
              'Popular Workouts',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : null,
              ),
            ),
            const SizedBox(height: AppConstants.spacingM),

            // Workout list
            _buildWorkoutCard(
              context,
              title: 'Cardio',
              exercises: '10 Exercises',
              duration: '50 Minutes',
              color: AppColors.cardio,
              imagePath: 'assets/images/cardio.jpg',
            ),
            const SizedBox(height: AppConstants.spacingM),
            _buildWorkoutCard(
              context,
              title: 'Arms',
              exercises: '6 Exercises',
              duration: '35 Minutes',
              color: AppColors.strength,
              imagePath: 'assets/images/arms.jpg',
            ),
            const SizedBox(height: AppConstants.spacingM),
            _buildWorkoutCard(
              context,
              title: 'Yoga',
              exercises: '8 Exercises',
              duration: '52 Minutes',
              color: AppColors.yoga,
              imagePath: 'assets/images/yoga.jpg',
            ),
            const SizedBox(height: AppConstants.spacingM),
            _buildWorkoutCard(
              context,
              title: 'Pilates',
              exercises: '6 Exercises',
              duration: '37 Minutes',
              color: AppColors.pilates,
              imagePath: 'assets/images/pilates.jpg',
            ),
            const SizedBox(height: AppConstants.spacingM),
            _buildWorkoutCard(
              context,
              title: 'Full Body',
              exercises: '8 Exercises',
              duration: '30 Minutes',
              color: AppColors.fullBody,
              imagePath: 'assets/images/full_body.jpg',
            ),
            const SizedBox(height: AppConstants.spacingM),
            _buildWorkoutCard(
              context,
              title: 'Stretching',
              exercises: '5 Exercises',
              duration: '25 Minutes',
              color: AppColors.stretching,
              imagePath: 'assets/images/stretching.jpg',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        // Filter workouts by category
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : color.withAlpha(40),
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          border:
              isDarkMode
                  ? Border.all(color: Colors.grey[700]!, width: 1)
                  : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: AppConstants.spacingS),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(
    BuildContext context, {
    required String title,
    required String exercises,
    required String duration,
    required Color color,
    required String imagePath,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => WorkoutDetailScreen(
                  title: title,
                  exercises: exercises,
                  duration: duration,
                  color: color,
                  imagePath: imagePath,
                ),
          ),
        );
      },
      child: Container(
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
        child: Row(
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
                    child: Icon(Icons.fitness_center, color: color, size: 35),
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
                                : theme.colorScheme.onSurface.withAlpha(179),
                      ),
                    ),
                    Text(
                      duration,
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
      ),
    );
  }
}
