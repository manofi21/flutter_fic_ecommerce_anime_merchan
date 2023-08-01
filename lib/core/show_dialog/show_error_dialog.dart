import 'package:flutter/material.dart';

void showErrorDialog({required BuildContext context, required String message}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message)
          ],
        ),
      );
    },
  );
}
