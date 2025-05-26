import 'package:calculator/app/core/enum/custom_colors.dart';
import 'package:calculator/app/product/cache/hive/model/hive_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
sealed class AllThemes with HiveModelMixin {
  static String get value => 'theme';

  ThemeData get theme;
}

@HiveType(typeId: 2)
class CustomLightTheme extends AllThemes {
  ThemeData get theme => ThemeData.light().copyWith(
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: CustomColors.bodySmall.getColor,
          ),
          titleSmall: TextStyle(
            color: CustomColors.white.getColor,
          ),
          titleLarge: TextStyle(
            color: CustomColors.white.getColor,
          ),
          titleMedium: TextStyle(
            color: CustomColors.white.getColor,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: CustomColors.bottombarBackground.getColor,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          unselectedItemColor: CustomColors.white.getColor,
          backgroundColor: CustomColors.bottombarBackground.getColor,
        ),
        scaffoldBackgroundColor: CustomColors.scaffoldBackground.getColor,
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: CustomColors.bodySmall.getColor,
        ),
        iconTheme: IconThemeData(
          color: CustomColors.white.getColor,
        ),
      );

  @override
  String get key => 'lightTheme';
}
