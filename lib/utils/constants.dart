import 'package:flutter/material.dart';

// App Constants
class AppConstants {
  // App Name
  static const String appName = 'FitLife';
  
  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);
  
  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  
  // Border Radius
  static const double borderRadiusS = 4.0;
  static const double borderRadiusM = 8.0;
  static const double borderRadiusL = 16.0;
  static const double borderRadiusXL = 24.0;
  static const double borderRadiusXXL = 32.0;
  
  // Font Sizes
  static const double fontSizeXS = 12.0;
  static const double fontSizeS = 14.0;
  static const double fontSizeM = 16.0;
  static const double fontSizeL = 18.0;
  static const double fontSizeXL = 20.0;
  static const double fontSizeXXL = 24.0;
  static const double fontSizeXXXL = 32.0;
  
  // Icon Sizes
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;
  
  // Button Heights
  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 48.0;
  static const double buttonHeightL = 56.0;
  
  // Image Sizes
  static const double avatarSizeS = 32.0;
  static const double avatarSizeM = 48.0;
  static const double avatarSizeL = 64.0;
  static const double avatarSizeXL = 96.0;
  
  // Card Sizes
  static const double cardHeightS = 80.0;
  static const double cardHeightM = 120.0;
  static const double cardHeightL = 160.0;
  static const double cardHeightXL = 200.0;
}

// App Colors
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9D97FF);
  static const Color primaryDark = Color(0xFF4B44CC);
  
  // Secondary Colors
  static const Color secondary = Color(0xFFFF6584);
  static const Color secondaryLight = Color(0xFFFF97AB);
  static const Color secondaryDark = Color(0xFFCC3A5D);
  
  // Accent Colors
  static const Color accent = Color(0xFF43E97B);
  static const Color accentLight = Color(0xFF7EFFAA);
  static const Color accentDark = Color(0xFF00B248);
  
  // Neutral Colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFFB300);
  static const Color info = Color(0xFF039BE5);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  
  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF6C63FF),
    Color(0xFF4B44CC),
  ];
  
  static const List<Color> secondaryGradient = [
    Color(0xFFFF6584),
    Color(0xFFCC3A5D),
  ];
  
  static const List<Color> accentGradient = [
    Color(0xFF43E97B),
    Color(0xFF00B248),
  ];
  
  // Workout Category Colors
  static const Color yoga = Color(0xFF81D4FA);
  static const Color cardio = Color(0xFFFFAB91);
  static const Color strength = Color(0xFFA5D6A7);
  static const Color hiit = Color(0xFFF48FB1);
  static const Color pilates = Color(0xFFCE93D8);
  static const Color stretching = Color(0xFFFFCC80);
  static const Color fullBody = Color(0xFF9FA8DA);
}

// Text Styles
class AppTextStyles {
  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: AppConstants.fontSizeXXXL,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: AppConstants.fontSizeXXL,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: AppConstants.fontSizeXL,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: AppConstants.fontSizeL,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: AppConstants.fontSizeM,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: AppConstants.fontSizeS,
    color: AppColors.textSecondary,
    height: 1.5,
  );
  
  // Button Text
  static const TextStyle buttonLarge = TextStyle(
    fontSize: AppConstants.fontSizeL,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  
  static const TextStyle buttonMedium = TextStyle(
    fontSize: AppConstants.fontSizeM,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  
  static const TextStyle buttonSmall = TextStyle(
    fontSize: AppConstants.fontSizeS,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  
  // Caption
  static const TextStyle caption = TextStyle(
    fontSize: AppConstants.fontSizeXS,
    color: AppColors.textSecondary,
    height: 1.4,
  );
  
  // Label
  static const TextStyle label = TextStyle(
    fontSize: AppConstants.fontSizeS,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );
}
