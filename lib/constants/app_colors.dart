
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF00838F);
  static const Color lightBlue = Color(0xFFE0F7FA);
  static const Color accentColor = Color(0xFF00BFA5);
  static const Color backgroundColor = Colors.white;
  static const Color cardBackgroundColor = Color(0xFFF8F9FA);
  static const Color textColor = Colors.black87;
  static const Color secondaryTextColor = Colors.black54;
  static const Color errorColor = Colors.redAccent;
  static const Color disabledColor = Colors.grey;
}

class AppDarkColors {
  static const Color primaryColor = Color(0xFF00B8D4);
  static const Color lightBlue = Color(0xFF004D40);
  static const Color accentColor = Color(0xFF1DE9B6);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color cardBackgroundColor = Color(0xFF1E1E1E);
  static const Color textColor = Colors.white70;
  static const Color secondaryTextColor = Colors.white38;
  static const Color errorColor = Color(0xFFEF5350);
  static const Color disabledColor = Colors.grey;
}

class AppTheme {
  static ThemeData getTheme(ThemeMode themeMode) {
    final isDark = themeMode == ThemeMode.dark;

    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: isDark ? AppDarkColors.primaryColor : AppColors.primaryColor,
      scaffoldBackgroundColor:
      isDark ? AppDarkColors.backgroundColor : AppColors.backgroundColor,
      iconTheme: IconThemeData(
          color: isDark ? AppDarkColors.textColor : AppColors.textColor),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: isDark
                  ? AppDarkColors.secondaryTextColor
                  : AppColors.secondaryTextColor,
              width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:
              isDark ? AppDarkColors.primaryColor : AppColors.primaryColor,
              width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        prefixIconColor:
        isDark ? AppDarkColors.accentColor : AppColors.accentColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:
          isDark ? AppDarkColors.primaryColor : AppColors.primaryColor,
          foregroundColor: isDark ? Colors.black : Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark
            ? AppDarkColors.cardBackgroundColor
            : AppColors.cardBackgroundColor,
        iconTheme: IconThemeData(
            color: isDark ? AppDarkColors.textColor : AppColors.textColor),
      ),
      cardTheme: CardThemeData(
        color:
        isDark ? AppDarkColors.cardBackgroundColor : AppColors.cardBackgroundColor,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark
            ? AppDarkColors.secondaryTextColor
            : AppColors.secondaryTextColor,
        thickness: 1.0,
      ),
      disabledColor:
      isDark ? AppDarkColors.disabledColor : AppColors.disabledColor,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: isDark ? AppDarkColors.primaryColor : AppColors.primaryColor,
        onPrimary: isDark ? Colors.black : Colors.white,
        secondary: isDark ? AppDarkColors.accentColor : AppColors.accentColor,
        onSecondary: isDark ? AppDarkColors.textColor : AppColors.textColor,
        error: isDark ? AppDarkColors.errorColor : AppColors.errorColor,
        onError: Colors.white,
        background:
        isDark ? AppDarkColors.backgroundColor : AppColors.backgroundColor,
        onBackground: isDark ? AppDarkColors.textColor : AppColors.textColor,
        surface:
        isDark ? AppDarkColors.cardBackgroundColor : AppColors.cardBackgroundColor,
        onSurface: isDark ? AppDarkColors.textColor : AppColors.textColor,
      ),
    );

  }
}
