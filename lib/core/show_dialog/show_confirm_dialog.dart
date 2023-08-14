import 'package:flutter/material.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required String message,
  void Function()? ok,
  bool trueFalseOption = true,
}) {

  if (trueFalseOption) {
    assert(trueFalseOption && ok != null, 'ok parameter cannot null if trueFalseOption true');
  }

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: trueFalseOption
            ? <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () {
                    if (ok != null) ok();
                    Navigator.pop(context);
                  },
                  child: const Text("Yes"),
                ),
              ]
            : <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () {
                    if (ok != null) ok();
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"),
                ),
              ],
      );
    },
  );
}
