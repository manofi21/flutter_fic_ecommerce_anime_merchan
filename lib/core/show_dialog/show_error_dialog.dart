import 'package:flutter/material.dart';

Future<void> showErrorDialog({required BuildContext context, required String message}) {
  return showDialog(
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
