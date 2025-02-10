import 'package:flutter/material.dart';
import 'package:flutter_supabase/core/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: 3));
  }

  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppPallete.backgroundColor,
      ),
      chipTheme: ChipThemeData(
          color: WidgetStatePropertyAll(AppPallete.backgroundColor),
          side: BorderSide.none),
      inputDecorationTheme: InputDecorationTheme(
          border: _border(),
          contentPadding: const EdgeInsets.all(27),
          focusedBorder: _border(AppPallete.gradient3),
          enabledBorder: _border(),
          errorBorder: _border(AppPallete.errorColor)
          ),
          );
}
