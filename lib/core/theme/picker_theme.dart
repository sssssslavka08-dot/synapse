import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Тёмная тема для showDatePicker / showTimePicker — без белых «засветов».
Widget synapsePickerTheme(BuildContext context, Widget? child) {
  return Theme(
    data: Theme.of(context).copyWith(
      colorScheme: const ColorScheme.dark(
        primary: AppColors.tiffany,
        onPrimary: Colors.white,
        surface: AppColors.darkSurface,
        onSurface: AppColors.textPrimary,
        onSurfaceVariant: AppColors.textSecondary,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkSurface,
        surfaceTintColor: Colors.transparent,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.tiffany),
      ),
    ),
    child: child!,
  );
}
