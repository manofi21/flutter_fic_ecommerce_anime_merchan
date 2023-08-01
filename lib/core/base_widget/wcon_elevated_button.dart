import 'package:flutter/material.dart';

class WConElevatedButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  const WConElevatedButton({super.key, required this.title, required this.onPressed});

  @override
  State<WConElevatedButton> createState() => _WConElevatedButtonState();
}

class _WConElevatedButtonState extends State<WConElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(64.0),
        ),
      ),
      onPressed: widget.onPressed,
      child: Text(widget.title),
    );
  }
}
