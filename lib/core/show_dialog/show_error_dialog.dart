import 'package:flutter/material.dart';

Future<void> showErrorDialog(
    {required BuildContext context, required String message}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Error"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text(message)],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[600],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
