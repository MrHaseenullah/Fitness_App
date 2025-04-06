import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,

    // Colors
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryLight,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.secondaryLight,
      onSecondaryContainer: AppColors.secondaryDark,
      tertiary: AppColors.accent,
      onTertiary: Colors.white,
      tertiaryContainer: AppColors.accentLight,
      onTertiaryContainer: AppColors.accentDark,
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: AppColors.error.withOpacity(0.2),
      onErrorContainer: AppColors.error,
      background: AppColors.background,
      onBackground: AppColors.textPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceVariant: Colors.grey[100]!,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.textHint,
      shadow: Colors.black.withOpacity(0.1),
      inverseSurface: AppColors.textPrimary,
      onInverseSurface: Colors.white,
      inversePrimary: AppColors.primaryLight,
      surfaceTint: AppColors.primary.withOpacity(0.05),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading1,
      displayMedium: AppTextStyles.heading2,
      displaySmall: AppTextStyles.heading3,
      headlineMedium: AppTextStyles.heading3,
      headlineSmall: AppTextStyles.heading3.copyWith(
        fontWeight: FontWeight.w600,
      ),
      titleLarge: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
      titleMedium: AppTextStyles.bodyMedium.copyWith(
        fontWeight: FontWeight.bold,
      ),
      titleSmall: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.buttonMedium,
      labelMedium: AppTextStyles.label,
      labelSmall: AppTextStyles.caption,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.heading3,
      iconTheme: IconThemeData(
        color: AppColors.textPrimary,
        size: AppConstants.iconSizeM,
      ),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, AppConstants.buttonHeightM),
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.spacingL,
          vertical: AppConstants.spacingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        elevation: 0,
        textStyle: AppTextStyles.buttonMedium,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: Size(double.infinity, AppConstants.buttonHeightM),
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.spacingL,
          vertical: AppConstants.spacingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        side: BorderSide(color: AppColors.primary, width: 1.5),
        textStyle: AppTextStyles.buttonMedium.copyWith(
          color: AppColors.primary,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: Size(double.infinity, AppConstants.buttonHeightS),
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.spacingM,
          vertical: AppConstants.spacingS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        ),
        textStyle: AppTextStyles.buttonMedium.copyWith(
          color: AppColors.primary,
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppConstants.spacingL,
        vertical: AppConstants.spacingM,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
      errorStyle: AppTextStyles.caption.copyWith(color: AppColors.error),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      ),
      shadowColor: Colors.black.withOpacity(0.1),
      margin: EdgeInsets.symmetric(
        vertical: AppConstants.spacingS,
        horizontal: 0,
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey[100]!,
      disabledColor: Colors.grey[200]!,
      selectedColor: AppColors.primaryLight,
      secondarySelectedColor: AppColors.primary,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.spacingM,
        vertical: AppConstants.spacingXS,
      ),
      labelStyle: AppTextStyles.bodySmall,
      secondaryLabelStyle: AppTextStyles.bodySmall.copyWith(
        color: Colors.white,
      ),
      brightness: Brightness.light,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      ),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: Colors.grey[200]!,
      thickness: 1,
      space: AppConstants.spacingM,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      selectedLabelStyle: AppTextStyles.caption.copyWith(
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: AppTextStyles.caption,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusXL),
      ),
    ),

    // Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.primaryLight.withOpacity(0.3),
      thumbColor: AppColors.primary,
      overlayColor: AppColors.primary.withOpacity(0.2),
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primary,
      circularTrackColor: AppColors.primaryLight.withOpacity(0.3),
      linearTrackColor: AppColors.primaryLight.withOpacity(0.3),
    ),

    // Snack Bar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.textPrimary,
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.surface,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,

    // Colors
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryLight,
      onPrimary: Colors.black,
      primaryContainer: AppColors.primary,
      onPrimaryContainer: Colors.white,
      secondary: AppColors.secondaryLight,
      onSecondary: Colors.black,
      secondaryContainer: AppColors.secondary,
      onSecondaryContainer: Colors.white,
      tertiary: AppColors.accentLight,
      onTertiary: Colors.black,
      tertiaryContainer: AppColors.accent,
      onTertiaryContainer: Colors.white,
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: AppColors.error.withOpacity(0.2),
      onErrorContainer: AppColors.error,
      background: const Color(0xFF121212),
      onBackground: Colors.white,
      surface: const Color(0xFF1E1E1E),
      onSurface: Colors.white,
      surfaceVariant: const Color(0xFF2C2C2C),
      onSurfaceVariant: Colors.grey[300]!,
      outline: Colors.grey[600]!,
      shadow: Colors.black,
      inverseSurface: Colors.white,
      onInverseSurface: Colors.black,
      inversePrimary: AppColors.primary,
      surfaceTint: AppColors.primaryLight.withOpacity(0.05),
    ),

    // Text Theme (reusing the same styles but with dark mode colors)
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading1.copyWith(color: Colors.white),
      displayMedium: AppTextStyles.heading2.copyWith(color: Colors.white),
      displaySmall: AppTextStyles.heading3.copyWith(color: Colors.white),
      headlineMedium: AppTextStyles.heading3.copyWith(color: Colors.white),
      headlineSmall: AppTextStyles.heading3.copyWith(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleLarge: AppTextStyles.bodyLarge.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: AppTextStyles.bodyMedium.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleSmall: AppTextStyles.bodySmall.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: Colors.grey[300]!),
      labelLarge: AppTextStyles.buttonMedium,
      labelMedium: AppTextStyles.label.copyWith(color: Colors.white),
      labelSmall: AppTextStyles.caption.copyWith(color: Colors.grey[400]!),
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.heading3.copyWith(color: Colors.white),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: AppConstants.iconSizeM,
      ),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.black,
        minimumSize: Size(double.infinity, AppConstants.buttonHeightM),
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.spacingL,
          vertical: AppConstants.spacingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        elevation: 0,
        textStyle: AppTextStyles.buttonMedium,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        minimumSize: Size(double.infinity, AppConstants.buttonHeightM),
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.spacingL,
          vertical: AppConstants.spacingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        side: BorderSide(color: AppColors.primaryLight, width: 1.5),
        textStyle: AppTextStyles.buttonMedium.copyWith(
          color: AppColors.primaryLight,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        minimumSize: Size(double.infinity, AppConstants.buttonHeightS),
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.spacingM,
          vertical: AppConstants.spacingS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        ),
        textStyle: AppTextStyles.buttonMedium.copyWith(
          color: AppColors.primaryLight,
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2C2C),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppConstants.spacingL,
        vertical: AppConstants.spacingM,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        borderSide: BorderSide(color: AppColors.primaryLight, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[500]),
      errorStyle: AppTextStyles.caption.copyWith(color: AppColors.error),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: const Color(0xFF2C2C2C),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      ),
      shadowColor: Colors.black.withOpacity(0.3),
      margin: EdgeInsets.symmetric(
        vertical: AppConstants.spacingS,
        horizontal: 0,
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF2C2C2C),
      disabledColor: const Color(0xFF3C3C3C),
      selectedColor: AppColors.primary,
      secondarySelectedColor: AppColors.primaryLight,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.spacingM,
        vertical: AppConstants.spacingXS,
      ),
      labelStyle: AppTextStyles.bodySmall.copyWith(color: Colors.white),
      secondaryLabelStyle: AppTextStyles.bodySmall.copyWith(
        color: Colors.black,
      ),
      brightness: Brightness.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      ),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: Colors.grey[800]!,
      thickness: 1,
      space: AppConstants.spacingM,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: Colors.grey[500],
      selectedLabelStyle: AppTextStyles.caption.copyWith(
        fontWeight: FontWeight.w500,
        color: AppColors.primaryLight,
      ),
      unselectedLabelStyle: AppTextStyles.caption.copyWith(
        color: Colors.grey[500],
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: Colors.black,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusXL),
      ),
    ),

    // Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primaryLight,
      inactiveTrackColor: AppColors.primary.withOpacity(0.3),
      thumbColor: AppColors.primaryLight,
      overlayColor: AppColors.primaryLight.withOpacity(0.2),
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primaryLight,
      circularTrackColor: AppColors.primary.withOpacity(0.3),
      linearTrackColor: AppColors.primary.withOpacity(0.3),
    ),

    // Snack Bar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey[900],
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: const Color(0xFF2C2C2C),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      ),
    ),
  );
}
