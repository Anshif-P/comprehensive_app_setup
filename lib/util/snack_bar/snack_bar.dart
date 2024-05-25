import 'package:flutter/material.dart';
import 'package:shopping_app/util/constance/text_style.dart';

class CustomSnackBar {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppText.mediumLight,
        ),
      ),
    );
  }
}
