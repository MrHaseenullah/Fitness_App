import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/constants.dart' hide AppColors;
import '../models/exercise_model.dart';

class ProgressScreen extends StatefulWidget {
  final String workoutTitle;
  final Color workoutColor;
  final List<Exercise> exercises;

  const ProgressScreen({
    super.key,
    required this.workoutTitle,
    required this.workoutColor,
    required this.exercises,
  });

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late List<Exercise> _exercises;
  late Timer _timer;
  int _currentExerciseIndex = 0;
  int _secondsElapsed = 0;
  bool _isWorkoutStarted = false;
  bool _isWorkoutPaused = false;

  @override
  void initState() {
    super.initState();
    _exercises = widget.exercises;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isWorkoutStarted && !_isWorkoutPaused) {
        setState(() {
          _secondsElapsed++;

          // Update current exercise progress
          if (_currentExerciseIndex < _exercises.length) {
            Exercise currentExercise = _exercises[_currentExerciseIndex];

            if (currentExercise.type == ExerciseType.duration) {
              // For duration-based exercises, increment progress until target is reached
              if (currentExercise.progress < currentExercise.target) {
                currentExercise.progress++;

                // Move to next exercise if current one is complete
                if (currentExercise.progress >= currentExercise.target) {
                  if (_currentExerciseIndex < _exercises.length - 1) {
                    _currentExerciseIndex++;
                  }
                }
              }
            }
          }
        });
      }
    });
  }

  void _toggleWorkoutState() {
    setState(() {
      if (!_isWorkoutStarted) {
        _isWorkoutStarted = true;
      } else {
        _isWorkoutPaused = !_isWorkoutPaused;
      }
    });
  }

  void _completeRepBasedExercise() {
    if (_currentExerciseIndex < _exercises.length &&
        _isWorkoutStarted &&
        !_isWorkoutPaused) {
      setState(() {
        Exercise currentExercise = _exercises[_currentExerciseIndex];

        if (currentExercise.type == ExerciseType.repetition) {
          // For rep-based exercises, increment by 1 rep
          if (currentExercise.progress < currentExercise.target) {
            currentExercise.progress++;

            // Move to next exercise if current one is complete
            if (currentExercise.progress >= currentExercise.target) {
              if (_currentExerciseIndex < _exercises.length - 1) {
                _currentExerciseIndex++;
              }
            }
          }
        }
      });
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  double _calculateTotalProgress() {
    if (_exercises.isEmpty) return 0.0;

    int totalTargets = 0;
    int totalProgress = 0;

    for (var exercise in _exercises) {
      totalTargets += exercise.target;
      totalProgress += exercise.progress;
    }

    return totalTargets > 0 ? totalProgress / totalTargets : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final totalProgress = _calculateTotalProgress();

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          widget.workoutTitle,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : theme.colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timer and progress
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingM),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadiusL,
                  ),
                  border:
                      isDarkMode
                          ? Border.all(color: Colors.grey[700]!, width: 1)
                          : null,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Elapsed Time',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    isDarkMode
                                        ? Colors.white70
                                        : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatTime(_secondsElapsed),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: _toggleWorkoutState,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.workoutColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.borderRadiusM,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.spacingL,
                              vertical: AppConstants.spacingM,
                            ),
                          ),
                          child: Text(
                            !_isWorkoutStarted
                                ? 'Start'
                                : (_isWorkoutPaused ? 'Resume' : 'Pause'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingM),
                    // Overall progress bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Overall Progress',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    isDarkMode
                                        ? Colors.white70
                                        : Colors.grey[700],
                              ),
                            ),
                            Text(
                              '${(totalProgress * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadiusS,
                          ),
                          child: LinearProgressIndicator(
                            value: totalProgress,
                            backgroundColor:
                                isDarkMode
                                    ? Colors.grey[700]
                                    : Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              widget.workoutColor,
                            ),
                            minHeight: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.spacingL),

              // Current exercise
              if (_exercises.isNotEmpty) ...[
                Text(
                  'Current Exercise',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingM),
                _buildCurrentExerciseCard(isDarkMode, theme),

                const SizedBox(height: AppConstants.spacingL),

                // Upcoming exercises
                Text(
                  'Up Next',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingM),

                Expanded(
                  child: ListView.builder(
                    itemCount: _exercises.length - _currentExerciseIndex - 1,
                    itemBuilder: (context, index) {
                      final actualIndex = index + _currentExerciseIndex + 1;
                      if (actualIndex < _exercises.length) {
                        return _buildExerciseListItem(
                          _exercises[actualIndex],
                          isDarkMode,
                          theme,
                          actualIndex,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentExerciseCard(bool isDarkMode, ThemeData theme) {
    if (_currentExerciseIndex >= _exercises.length) {
      return Container(
        padding: const EdgeInsets.all(AppConstants.spacingM),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          border:
              isDarkMode
                  ? Border.all(color: Colors.grey[700]!, width: 1)
                  : null,
        ),
        child: Center(
          child: Text(
            'Workout Complete!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    }

    final exercise = _exercises[_currentExerciseIndex];
    final progress = exercise.progress;
    final target = exercise.target;
    final progressPercent = target > 0 ? progress / target : 0.0;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        border:
            isDarkMode ? Border.all(color: Colors.grey[700]!, width: 1) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exercise.type == ExerciseType.repetition
                          ? '$progress / $target reps'
                          : '${_formatTime(progress)} / ${_formatTime(target)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              if (exercise.type == ExerciseType.repetition)
                ElevatedButton(
                  onPressed:
                      _isWorkoutStarted && !_isWorkoutPaused
                          ? _completeRepBasedExercise
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.workoutColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadiusM,
                      ),
                    ),
                  ),
                  child: const Text('Complete Rep'),
                ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingM),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
            child: LinearProgressIndicator(
              value: progressPercent,
              backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(widget.workoutColor),
              minHeight: 10,
            ),
          ),
          if (exercise.description != null &&
              exercise.description!.isNotEmpty) ...[
            const SizedBox(height: AppConstants.spacingM),
            Text(
              exercise.description!,
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.white70 : Colors.grey[700],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExerciseListItem(
    Exercise exercise,
    bool isDarkMode,
    ThemeData theme,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        border:
            isDarkMode ? Border.all(color: Colors.grey[700]!, width: 1) : null,
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: widget.workoutColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                  color: widget.workoutColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppConstants.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  exercise.type == ExerciseType.repetition
                      ? '${exercise.target} reps'
                      : _formatTime(exercise.target),
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.white70 : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
