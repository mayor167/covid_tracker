import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class RTextTheme {
  RTextTheme._(); // To avoid creating instances

  static TextTheme lighRTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: RColors.dark,
        fontFamilyFallback: [
          'Roboto'
        ]), // the fallback font makes naira show on android
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: RColors.dark,
        fontFamilyFallback: ['Roboto']),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: RColors.dark),

    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: RColors.dark,
        fontFamilyFallback: ['Roboto']),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: RColors.dark,
        fontFamilyFallback: ['Roboto']),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: RColors.dark,
        fontFamilyFallback: ['Roboto']),

    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: RColors.dark,
        fontFamilyFallback: ['Roboto']),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: RColors.dark,
        fontFamilyFallback: ['Roboto']),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: RColors.dark.withAlpha(128),
        fontFamilyFallback: ['Roboto']),

    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: RColors.dark,
        fontFamilyFallback: ['Roboto']),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: RColors.dark.withAlpha(128),
        fontFamilyFallback: ['Roboto']),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: RColors.light,
        fontFamilyFallback: ['Roboto']),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: RColors.light,
        fontFamilyFallback: ['Roboto']),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: RColors.light),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: RColors.light,
        fontFamilyFallback: ['Roboto']),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: RColors.light,
        fontFamilyFallback: ['Roboto']),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: RColors.light,
        fontFamilyFallback: ['Roboto']),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: RColors.light,
        fontFamilyFallback: ['Roboto']),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: RColors.light,
        fontFamilyFallback: ['Roboto']),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: RColors.light.withAlpha(128),
        fontFamilyFallback: ['Roboto']),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: RColors.light,
        fontFamilyFallback: ['Roboto']),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: RColors.light.withAlpha(128),
        fontFamilyFallback: ['Roboto']),
  );
}
