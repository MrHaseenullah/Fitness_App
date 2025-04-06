import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  
  // Mock workout events
  final Map<DateTime, List<String>> _events = {
    DateTime.now().subtract(const Duration(days: 2)): ['Cardio Workout', 'Yoga Session'],
    DateTime.now().subtract(const Duration(days: 1)): ['Full Body Workout'],
    DateTime.now(): ['Arms Workout', 'Stretching'],
    DateTime.now().add(const Duration(days: 1)): ['Pilates Session'],
    DateTime.now().add(const Duration(days: 3)): ['Cardio Workout', 'Yoga Session'],
    DateTime.now().add(const Duration(days: 5)): ['Full Body Workout'],
  };

  List<String> _getEventsForDay(DateTime day) {
    // Normalize date to avoid time comparison issues
    final normalizedDay = DateTime(day.year, day.month, day.day);
    
    return _events.entries
        .where((entry) => 
            entry.key.year == normalizedDay.year && 
            entry.key.month == normalizedDay.month && 
            entry.key.day == normalizedDay.day)
        .expand((entry) => entry.value)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Workout Calendar'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Calendar
          Card(
            margin: const EdgeInsets.all(AppConstants.spacingM),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingS),
              child: TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                eventLoader: _getEventsForDay,
                calendarStyle: CalendarStyle(
                  markersMaxCount: 3,
                  markerDecoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonDecoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                  ),
                  formatButtonTextStyle: TextStyle(
                    color: theme.colorScheme.primary,
                  ),
                  titleCentered: true,
                ),
              ),
            ),
          ),
          
          // Events for selected day
          Expanded(
            child: _selectedDay == null
                ? Center(
                    child: Text(
                      'Select a day to see workouts',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  )
                : _buildEventList(theme),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // This would typically open a dialog to add a new workout
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add workout feature coming soon')),
          );
        },
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEventList(ThemeData theme) {
    final events = _getEventsForDay(_selectedDay!);
    
    if (events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 64,
              color: theme.colorScheme.onSurface.withOpacity(0.2),
            ),
            const SizedBox(height: AppConstants.spacingM),
            Text(
              'No workouts scheduled',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: AppConstants.spacingS),
            Text(
              'Tap the + button to add a workout',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.4),
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(AppConstants.spacingM),
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
              child: Icon(
                Icons.fitness_center,
                color: theme.colorScheme.primary,
              ),
            ),
            title: Text(
              events[index],
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Scheduled for ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
              style: theme.textTheme.bodySmall,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Show options menu
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Options coming soon')),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
