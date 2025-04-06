import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../providers/auth_provider.dart';
import '../providers/blog_provider.dart';
import '../widgets/blog_post_card.dart';
import 'workout_detail_screen.dart';
import 'discover_workouts_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with user info and avatar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, ${user?.fullName.split(' ')[0] ?? 'User'}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingXS),
                        Text(
                          "Let's check your activity",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(179),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.primary.withAlpha(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/profile_avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingXL),

                // Activity Stats
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Completed Workouts
                    _buildStatCard(
                      context,
                      title: 'Finished',
                      value: '12',
                      subtitle: 'Completed workouts',
                      backgroundColor: theme.colorScheme.surface,
                      valueColor: theme.colorScheme.primary,
                      height:
                          200, // Match the combined height of the two cards + spacing
                      width: 180,
                      titleFontSize: 18,
                      valueFontSize: 62,
                      subtitleFontSize: 14,
                    ),
                    const SizedBox(width: AppConstants.spacingM),

                    // In Progress & Time Spent
                    Column(
                      children: [
                        _buildStatCard(
                          context,
                          title: 'In Progress',
                          value: '2',
                          subtitle: 'Workouts',
                          backgroundColor: theme.colorScheme.surface,
                          valueColor: theme.colorScheme.secondary,
                          height: 90,
                          width: 150,
                          titleFontSize: 14,
                          valueFontSize: 32,
                          subtitleFontSize: 12,
                          compactMode: true,
                        ),
                        const SizedBox(height: AppConstants.spacingM),
                        _buildStatCard(
                          context,
                          title: 'Time spent',
                          value: '62',
                          subtitle: 'Minutes',
                          backgroundColor: theme.colorScheme.surface,
                          valueColor: theme.colorScheme.tertiary,
                          height: 90,
                          width: 150,
                          titleFontSize: 14,
                          valueFontSize: 28,
                          subtitleFontSize: 12,
                          compactMode: true,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingXL),

                // Discover new workouts section with forward arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover new workouts',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const DiscoverWorkoutsScreen(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'See all',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingM),

                // Workout Cards
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildWorkoutCard(
                        context,
                        title: 'Cardio',
                        exercises: '10 Exercises',
                        duration: '50 Minutes',
                        color: AppColors.cardio,
                        imagePath: 'assets/images/cardio.jpg',
                      ),
                      const SizedBox(width: AppConstants.spacingM),
                      _buildWorkoutCard(
                        context,
                        title: 'Arms',
                        exercises: '6 Exercises',
                        duration: '35 Minutes',
                        color: AppColors.strength,
                        imagePath: 'assets/images/arms.jpg',
                      ),
                      const SizedBox(width: AppConstants.spacingM),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const DiscoverWorkoutsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 180,
                          decoration: BoxDecoration(
                            color:
                                isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[200],
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadiusL,
                            ),
                            border:
                                isDarkMode
                                    ? Border.all(
                                      color: Colors.grey[700]!,
                                      width: 1,
                                    )
                                    : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                size: 40,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(height: AppConstants.spacingS),
                              Text(
                                'See More',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.spacingXL),

                // Progress Card
                Container(
                  padding: const EdgeInsets.all(AppConstants.spacingM),
                  decoration: BoxDecoration(
                    color:
                        isDarkMode
                            ? Colors.grey[800]
                            : theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(
                      AppConstants.borderRadiusL,
                    ),
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
                      Text(
                        'Keep the progress!',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : null,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingS),
                      Text(
                        'You are more successful than 80% users',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color:
                              isDarkMode
                                  ? Colors.white.withAlpha(179)
                                  : theme.colorScheme.onSurface.withAlpha(179),
                        ),
                      ),
                    ],
                  ),
                ),

                // Blog Posts Section
                const SizedBox(height: AppConstants.spacingXL),

                Text(
                  'Fitness Articles',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingM),

                // Blog posts list
                _buildBlogPostsList(context),

                // Add some bottom padding for the nav bar
                const SizedBox(height: AppConstants.spacingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required Color backgroundColor,
    required Color valueColor,
    double? height,
    double? width,
    double? titleFontSize,
    double? valueFontSize,
    double? subtitleFontSize,
    bool compactMode = false,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(
        compactMode ? AppConstants.spacingS : AppConstants.spacingM,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : backgroundColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        border:
            isDarkMode ? Border.all(color: Colors.grey[700]!, width: 1) : null,
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
        mainAxisAlignment:
            compactMode
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color:
                  isDarkMode
                      ? Colors.white.withAlpha(230)
                      : theme.colorScheme.onSurface.withAlpha(179),
              fontSize: titleFontSize ?? (compactMode ? 12 : null),
            ),
          ),
          SizedBox(height: compactMode ? 4 : AppConstants.spacingM),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: valueColor,
              fontSize: valueFontSize ?? (compactMode ? 24 : 36),
              height: 1.0,
            ),
          ),
          SizedBox(height: compactMode ? 2 : AppConstants.spacingXS),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color:
                  isDarkMode
                      ? Colors.white.withAlpha(179)
                      : theme.colorScheme.onSurface.withAlpha(179),
              fontSize: subtitleFontSize ?? (compactMode ? 10 : null),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Build the blog posts list
  Widget _buildBlogPostsList(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final recentPosts = blogProvider.getRecentBlogPosts(limit: 5);

    return Column(
      children: [
        // Blog post cards
        ...recentPosts.map((post) => BlogPostCard(blogPost: post)),

        // See more button
        const SizedBox(height: AppConstants.spacingM),
        GestureDetector(
          onTap: () {
            // Show all blog posts in a dialog
            showDialog(
              context: context,
              builder: (context) => _buildAllBlogPostsDialog(context),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingL,
              vertical: AppConstants.spacingM,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
            ),
            child: const Text(
              'See All Articles',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Dialog to show all blog posts
  Widget _buildAllBlogPostsDialog(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final allPosts = blogProvider.blogPosts;
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(AppConstants.spacingM),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.8,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        child: Column(
          children: [
            // Header with close button
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Fitness Articles',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Blog posts list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(AppConstants.spacingM),
                itemCount: allPosts.length,
                itemBuilder:
                    (context, index) => BlogPostCard(blogPost: allPosts[index]),
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
    final textColor = isDarkMode ? Colors.white : Colors.black;

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
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          border:
              isDarkMode
                  ? Border.all(color: Colors.grey[700]!, width: 1)
                  : null,
        ),
        child: Stack(
          children: [
            // Background image with opacity
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                child: Opacity(
                  opacity: 0.6, // 60% opacity
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
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
              ),
            ),
            // Content
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                // Add a slight gradient overlay to ensure text readability
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withAlpha(100), color.withAlpha(40)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(128),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    exercises,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: textColor,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(128),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    duration,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: textColor,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(128),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
