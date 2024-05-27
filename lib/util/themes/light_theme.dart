import 'package:finfresh_machin_task/util/constance/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: Colors.black,
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColor.primaryColor,
        tertiary: const Color.fromRGBO(0, 0, 0, 1),
        onPrimary: Colors.black,
        secondary: AppColor.secondaryColor,
        onSecondary: const Color(0xFF3C654D),
        error: Colors.red,
        onError: Colors.white,
        background: AppColor.backgroundColor,
        onBackground: Colors.white,
        surface: const Color(0xffBEBEBE),
        onSurface: Colors.white,
        onSecondaryContainer: Colors.black,
        onTertiary: Colors.grey.shade800),
    iconTheme: const IconThemeData(color: AppColor.grey),
    fontFamily: 'ubuntu',
    appBarTheme: const AppBarTheme(foregroundColor: Colors.black));
