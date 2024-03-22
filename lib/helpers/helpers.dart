// All Flutter Built-in Imports Here.
import 'package:flutter/material.dart';

// All Custom Imports Here.

// All Native Imports Here.

// All Attributes or Constants Here.

void showMessage(BuildContext context, String message, Color? color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color ?? Colors.black,
      content: Text(message),
      duration: const Duration(seconds: 3),
    ),
  );
}
