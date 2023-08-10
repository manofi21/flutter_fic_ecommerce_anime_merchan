import 'package:flutter/material.dart';

Widget iconDetailBar({required double opacity, required IconData icon}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    padding: const EdgeInsets.all(5.5),
    decoration: BoxDecoration(
      color: Color.lerp(
        Colors.black.withOpacity(.5),
        Colors.white,
        opacity,
      ),
      shape: BoxShape.circle,
    ),
    child: Icon(
      icon,
      size: 23,
      color: Color.lerp(
        Colors.white,
        Colors.orange,
        opacity * 2.5,
      ),
    ),
  );
}