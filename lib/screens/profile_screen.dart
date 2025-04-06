import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/constants.dart';
import 'edit_profile_screen.dart';
import 'calendar_screen.dart';
import 'reminder_screen.dart';
import 'terms_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Header
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary.withAlpha(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/profile_avatar.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.spacingM),
                Text(
                  user?.fullName ?? 'User',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingXL),

                // Settings Options
                _buildSettingItem(
                  context,
                  icon: Icons.edit,
                  title: 'Edit Profile',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                ),
                _buildDivider(),

                _buildSettingItem(
                  context,
                  icon: Icons.calendar_today,
                  title: 'Calendar',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalendarScreen(),
                      ),
                    );
                  },
                ),
                _buildDivider(),

                _buildSettingItem(
                  context,
                  icon: Icons.notifications_none,
                  title: 'Reminder',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReminderScreen(),
                      ),
                    );
                  },
                ),
                _buildDivider(),

                _buildSettingItem(
                  context,
                  icon: Icons.star_border,
                  title: 'Rate us on App store',
                  onTap: () {},
                ),
                _buildDivider(),

                // Theme Toggle
                _buildThemeToggle(context),
                _buildDivider(),

                _buildSettingItem(
                  context,
                  icon: Icons.description_outlined,
                  title: 'Terms & Conditions',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsScreen(),
                      ),
                    );
                  },
                ),
                _buildDivider(),

                _buildSettingItem(
                  context,
                  icon: Icons.logout,
                  title: 'Signout',
                  onTap: () async {
                    final authProvider = Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    );
                    final success = await authProvider.signOut();
                    if (success && context.mounted) {
                      Navigator.pushReplacementNamed(context, '/sign_in');
                    }
                  },
                  textColor: theme.colorScheme.error,
                  iconColor: theme.colorScheme.error,
                ),
                const SizedBox(height: AppConstants.spacingXXL),

                // Social Media
                Text(
                  'Join us on social media',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingL),

                // Social Media Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(
                      context,
                      icon: Icons.facebook,
                      color: const Color(0xFF1877F2),
                      onTap: () {},
                    ),
                    const SizedBox(width: AppConstants.spacingL),
                    _buildSocialButton(
                      context,
                      icon: Icons.link,
                      color: const Color(0xFF0077B5),
                      onTap: () {},
                    ),
                    const SizedBox(width: AppConstants.spacingL),
                    _buildSocialButton(
                      context,
                      icon: Icons.alternate_email,
                      color: Colors.black,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: (iconColor ?? theme.colorScheme.primary).withAlpha(20),
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        ),
        child: Icon(icon, color: iconColor ?? theme.colorScheme.primary),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          color: textColor ?? theme.colorScheme.onSurface,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: theme.colorScheme.onSurface.withAlpha(179),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, indent: 56);
  }

  // Theme toggle switch
  Widget _buildThemeToggle(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withAlpha(20),
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        ),
        child: Icon(
          themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: theme.colorScheme.primary,
        ),
      ),
      title: Text('Dark Mode', style: theme.textTheme.titleMedium),
      trailing: Switch(
        value: themeProvider.isDarkMode,
        onChanged: (_) => themeProvider.toggleTheme(),
        activeColor: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}
