import 'package:flutter/material.dart';

mixin AppSnackBar {
  static void error(BuildContext context, {String message = ""}) {
    ScaffoldMessenger.of(context).showSnackBar(_snackBarWidget(
      context,
      message: message,
    ));
  }

  static SnackBar _snackBarWidget(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Color(0xFFC04E50),
      duration: const Duration(seconds: 3),
    );
  }
}
