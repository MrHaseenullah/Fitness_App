import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  // Mock reminders
  final List<Reminder> _reminders = [
    Reminder(
      id: '1',
      title: 'Morning Workout',
      time: TimeOfDay(hour: 7, minute: 0),
      days: {
        'Monday': true,
        'Tuesday': true,
        'Wednesday': true,
        'Thursday': true,
        'Friday': true,
        'Saturday': false,
        'Sunday': false,
      },
      isEnabled: true,
    ),
    Reminder(
      id: '2',
      title: 'Evening Stretching',
      time: TimeOfDay(hour: 19, minute: 30),
      days: {
        'Monday': true,
        'Tuesday': true,
        'Wednesday': true,
        'Thursday': true,
        'Friday': true,
        'Saturday': true,
        'Sunday': true,
      },
      isEnabled: true,
    ),
    Reminder(
      id: '3',
      title: 'Weekend Yoga',
      time: TimeOfDay(hour: 9, minute: 0),
      days: {
        'Monday': false,
        'Tuesday': false,
        'Wednesday': false,
        'Thursday': false,
        'Friday': false,
        'Saturday': true,
        'Sunday': true,
      },
      isEnabled: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Workout Reminders',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: isDarkMode ? Colors.black : theme.colorScheme.surface,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        elevation: 0,
      ),
      body:
          _reminders.isEmpty
              ? _buildEmptyState(theme)
              : ListView.builder(
                padding: const EdgeInsets.all(AppConstants.spacingM),
                itemCount: _reminders.length,
                itemBuilder: (context, index) {
                  final reminder = _reminders[index];
                  return _buildReminderCard(theme, reminder, index);
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddReminderDialog(context),
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 64,
            color: theme.colorScheme.onSurface.withOpacity(0.2),
          ),
          const SizedBox(height: AppConstants.spacingM),
          Text(
            'No reminders set',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: AppConstants.spacingS),
          Text(
            'Tap the + button to add a reminder',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard(ThemeData theme, Reminder reminder, int index) {
    final activeDays = reminder.days.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key.substring(0, 3))
        .join(', ');

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingM),
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
                        reminder.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingXS),
                      Text(
                        '${reminder.time.format(context)} • $activeDays',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: reminder.isEnabled,
                  onChanged: (value) {
                    setState(() {
                      _reminders[index] = reminder.copyWith(isEnabled: value);
                    });
                  },
                  activeColor: theme.colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingS),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed:
                      () => _showEditReminderDialog(context, reminder, index),
                  icon: Icon(
                    Icons.edit_outlined,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  label: Text(
                    'Edit',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.spacingS),
                TextButton.icon(
                  onPressed: () => _deleteReminder(index),
                  icon: Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: theme.colorScheme.error,
                  ),
                  label: Text(
                    'Delete',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddReminderDialog(BuildContext context) {
    final titleController = TextEditingController();
    TimeOfDay selectedTime = TimeOfDay.now();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Reminder'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Reminder Title',
                      hintText: 'e.g., Morning Workout',
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingM),
                  const Text('Time'),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(selectedTime.format(context)),
                    trailing: const Icon(Icons.access_time),
                    onTap: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (time != null) {
                        selectedTime = time;
                        // This would update the UI in a real implementation
                      }
                    },
                  ),
                  const SizedBox(height: AppConstants.spacingS),
                  const Text('Repeat on'),
                  const SizedBox(height: AppConstants.spacingXS),
                  // This would be a list of day selection widgets in a real implementation
                  Text('Day selection would be implemented here'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // In a real app, we would add the reminder here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add reminder feature coming soon'),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  void _showEditReminderDialog(
    BuildContext context,
    Reminder reminder,
    int index,
  ) {
    // In a real app, this would open a dialog to edit the reminder
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit reminder feature coming soon')),
    );
  }

  void _deleteReminder(int index) {
    setState(() {
      _reminders.removeAt(index);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Reminder deleted')));
  }
}

class Reminder {
  final String id;
  final String title;
  final TimeOfDay time;
  final Map<String, bool> days;
  final bool isEnabled;

  Reminder({
    required this.id,
    required this.title,
    required this.time,
    required this.days,
    required this.isEnabled,
  });

  Reminder copyWith({
    String? id,
    String? title,
    TimeOfDay? time,
    Map<String, bool>? days,
    bool? isEnabled,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      days: days ?? this.days,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
