import 'package:flutter/material.dart';

import '../constance/colors.dart';

ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey.shade700,
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.grey.shade100,
        onPrimary: Colors.grey.shade800,
        secondary: AppColor.secondaryColor,
        onSecondary: Colors.grey.shade500,
        error: Colors.red,
        onError: Colors.pink,
        background: Colors.grey.shade900,
        onBackground: Colors.grey.shade500,
        tertiary: Colors.grey.shade500,
        surface: Colors.grey.shade200,
        onSurface: Colors.grey.shade400,
        onTertiary: Colors.grey.shade300,
        onSecondaryContainer: Colors.white),
    iconTheme: const IconThemeData(color: AppColor.grey),
    fontFamily: 'ubuntu');
