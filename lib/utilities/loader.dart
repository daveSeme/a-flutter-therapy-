import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

Future getFuture() {
  return Future(() async {
    await Future.delayed(const Duration(seconds: 5));
    return 'Hello, Future Progress Dialog!';
  });
}

class Loader {
  void showCustomDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) =>
          FutureProgressDialog(getFuture(), message: Text(message)),
    );
  }
}