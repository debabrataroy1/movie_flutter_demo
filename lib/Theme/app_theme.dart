import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/app_constants.dart';

class ThemeManager {
  static ThemeManager? _instance;

  static ThemeManager get instance {
    _instance ??= ThemeManager._init();
    return _instance!;
  }

  ThemeManager._init();

  ThemeData? get light => ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: const Color(0xfffafafa),
      cardColor: const Color(0xffffffff),
      dividerColor: const Color(0x1f000000),
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primaryColor,
          onPrimary: Color(0xffffffff),
          secondary: AppColors.primaryColor,
          onSecondary: AppColors.primaryColor,
          error: Color(0xffd32f2f),
          onError: Color(0xffd32f2f),
          background: Color(0xffFAFAFA),
          onBackground: Color(0xffb0a2f6),
          surface: Color(0xff9784f3),
          onSurface: Color(0xff000000)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(
                horizontal: AppPaddings.regular, vertical: AppPaddings.small),
            textStyle: const TextStyle(
              fontSize: AppFontSize.regular,
              fontWeight: FontWeight.w600,
              color: Color(0xffffffff),
            )
        ),
      )
  );

  ThemeData? get dark => ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xff212121),
      scaffoldBackgroundColor: const Color(0xff303030),
      cardColor: const Color(0xff424242),
      dividerColor: const Color(0x1fffffff),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xff212121),
        onPrimary: Color(0xffffffff),
        secondary: Color(0xff212121),
        onSecondary: Color(0xff212121),
        error: Color(0xffd32f2f),
        onError: Color(0xffd32f2f),
        background: Color(0xff616161),
        onBackground: Color(0xff616161),
        surface: Color(0xff000000),
        onSurface: Color(0xffffffff),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 2,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPaddings.regular, vertical: AppPaddings.small),
              textStyle: const TextStyle(
                fontSize: AppFontSize.regular,
                fontWeight: FontWeight.w600,
                color: Color(0xffffffff),
              )
          )
      )
  );
}
