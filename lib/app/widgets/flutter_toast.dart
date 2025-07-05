import 'package:flutter/material.dart';
import 'package:sakinah/main.dart';

void showToast(
  String text, {
  Duration duration = const Duration(seconds: 3),
}) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: ThemeData.light().colorScheme.secondaryContainer,
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(color: ThemeData.light().colorScheme.inverseSurface),
      ),
      duration: duration,
    ),
  );
}

void showToastWithButton(
  String text,
  String buttonName,
  VoidCallback onPressedToast, {
  Duration duration = const Duration(seconds: 3),
}) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: ThemeData.light().colorScheme.secondaryContainer,
      content: Text(
        text,
        style: TextStyle(color: ThemeData.light().colorScheme.inverseSurface),
      ),
      action: SnackBarAction(
        label: buttonName,
        textColor: ThemeData.light().colorScheme.secondary,
        onPressed: onPressedToast,
      ),
      duration: duration,
    ),
  );
}
