import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../utils/constants.dart';

class WorkoutCard extends StatefulWidget {
  final Workout workout;
  final VoidCallback onTap;
  final bool isHorizontal;

  const WorkoutCard({
    Key? key,
    required this.workout,
    required this.onTap,
    this.isHorizontal = true,
  }) : super(key: key);

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.shortAnimationDuration,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.isHorizontal
                ? _buildHorizontalCard(theme)
                : _buildVerticalCard(theme),
          );
        },
      ),
    );
  }

  Widget _buildHorizontalCard(ThemeData theme) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: AppConstants.spacingM),
      decoration: BoxDecoration(
        color: widget.workout.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        boxShadow: [
          BoxShadow(
            color: widget.workout.color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppConstants.borderRadiusL),
              topRight: Radius.circular(AppConstants.borderRadiusL),
            ),
            child: Image.asset(
              widget.workout.imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 140,
                  width: double.infinity,
                  color: widget.workout.color.withOpacity(0.3),
                  child: Icon(
                    Icons.fitness_center,
                    size: 48,
                    color: widget.workout.color,
                  ),
                );
              },
            ),
          ),
          
          // Content section
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category chip
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingS,
                    vertical: AppConstants.spacingXS,
                  ),
                  decoration: BoxDecoration(
                    color: widget.workout.color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
                  ),
                  child: Text(
                    widget.workout.category.toString().split('.').last.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: widget.workout.color.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacingS),
                
                // Title
                Text(
                  widget.workout.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: AppConstants.spacingXS),
                
                // Details
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.workout.formattedDuration,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(width: AppConstants.spacingM),
                    Icon(
                      Icons.fitness_center,
                      size: 16,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.workout.exerciseCount,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalCard(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppConstants.borderRadiusL),
              bottomLeft: Radius.circular(AppConstants.borderRadiusL),
            ),
            child: Image.asset(
              widget.workout.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  width: 100,
                  color: widget.workout.color.withOpacity(0.3),
                  child: Icon(
                    Icons.fitness_center,
                    size: 32,
                    color: widget.workout.color,
                  ),
                );
              },
            ),
          ),
          
          // Content section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingS,
                      vertical: AppConstants.spacingXS,
                    ),
                    decoration: BoxDecoration(
                      color: widget.workout.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
                    ),
                    child: Text(
                      widget.workout.category.toString().split('.').last.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: widget.workout.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacingS),
                  
                  // Title
                  Text(
                    widget.workout.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: AppConstants.spacingXS),
                  
                  // Details
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.workout.formattedDuration,
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(width: AppConstants.spacingM),
                      Icon(
                        Icons.fitness_center,
                        size: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.workout.exerciseCount,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
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
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
