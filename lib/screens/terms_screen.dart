import 'package:flutter/material.dart';
import '../utils/constants.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppConstants.spacingM),
            Text(
              'Last Updated: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: AppConstants.spacingXL),
            
            _buildSection(
              theme,
              title: '1. Introduction',
              content: 'Welcome to FitLife, a fitness application designed to help you achieve your fitness goals. By using our application, you agree to these Terms and Conditions, which will govern your use of the application and all related services.',
            ),
            
            _buildSection(
              theme,
              title: '2. Acceptance of Terms',
              content: 'By accessing or using the FitLife application, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, you may not use our application.',
            ),
            
            _buildSection(
              theme,
              title: '3. User Accounts',
              content: 'To use certain features of the application, you may need to create a user account. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.',
            ),
            
            _buildSection(
              theme,
              title: '4. User Content',
              content: 'You may have the ability to post content to the application. You retain ownership of any content you submit, but grant us a worldwide, non-exclusive, royalty-free license to use, reproduce, modify, adapt, publish, translate, and distribute your content in any existing or future media.',
            ),
            
            _buildSection(
              theme,
              title: '5. Health Disclaimer',
              content: 'The content provided in the FitLife application is for informational purposes only and is not intended as medical advice. Always consult with a qualified healthcare provider before beginning any exercise program or making changes to your diet or health routine.',
            ),
            
            _buildSection(
              theme,
              title: '6. Privacy Policy',
              content: 'Your use of the FitLife application is also governed by our Privacy Policy, which can be found within the application. By using the application, you consent to the practices described in the Privacy Policy.',
            ),
            
            _buildSection(
              theme,
              title: '7. Limitation of Liability',
              content: 'To the maximum extent permitted by law, FitLife and its affiliates shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses resulting from your use or inability to use the application.',
            ),
            
            _buildSection(
              theme,
              title: '8. Changes to Terms',
              content: 'We reserve the right to modify these Terms and Conditions at any time. We will provide notice of significant changes by posting the updated terms on the application. Your continued use of the application after such modifications constitutes your acceptance of the revised terms.',
            ),
            
            _buildSection(
              theme,
              title: '9. Termination',
              content: 'We may terminate or suspend your account and access to the application at our sole discretion, without prior notice or liability, for any reason, including if you breach these Terms and Conditions.',
            ),
            
            _buildSection(
              theme,
              title: '10. Contact Us',
              content: 'If you have any questions about these Terms and Conditions, please contact us at support@fitlife.example.com.',
            ),
            
            const SizedBox(height: AppConstants.spacingXL),
            
            Center(
              child: Text(
                '© ${DateTime.now().year} FitLife. All rights reserved.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(height: AppConstants.spacingL),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    ThemeData theme, {
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.spacingS),
          Text(
            content,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
