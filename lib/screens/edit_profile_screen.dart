import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/constants.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/animated_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _fullNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize the text field with the current user's name
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    if (user != null) {
      _fullNameController.text = user.fullName;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.updateUserProfile(
        fullName: _fullNameController.text.trim(),
      );

      setState(() {
        _isLoading = false;
      });

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacingL),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image
                  Container(
                    width: 120,
                    height: 120,
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

                  // Change Photo Button
                  TextButton.icon(
                    onPressed: () {
                      // This would typically open an image picker
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Feature coming soon')),
                      );
                    },
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: theme.colorScheme.primary,
                    ),
                    label: Text(
                      'Change Photo',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingXL),

                  // Full Name Field
                  CustomTextField(
                    controller: _fullNameController,
                    hintText: 'Full Name',
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: theme.colorScheme.primary,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppConstants.spacingM),

                  // Email Field (disabled)
                  CustomTextField(
                    controller: TextEditingController(text: user?.email ?? ''),
                    hintText: 'Email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: theme.colorScheme.onSurface.withAlpha(128),
                    ),
                    enabled: false,
                  ),
                  const SizedBox(height: AppConstants.spacingXL),

                  // Save Button
                  AnimatedButton(
                    text: 'Save Changes',
                    onPressed: _saveProfile,
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
