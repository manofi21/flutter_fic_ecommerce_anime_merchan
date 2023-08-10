import 'package:flutter/material.dart';

Widget buttonToSearchPage({required double opacity, required List<String> texts, required int currentIndex}) {
  return Opacity(
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 6,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6.5,
            horizontal: 2,
          ),
          color: Color.lerp(
            Colors.white,
            Colors.grey.shade300,
            opacity,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.search, color: Colors.grey.shade500),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                layoutBuilder: (child, children) {
                  return Stack(
                    children: [
                      if (child != null) child,
                      ...children,
                    ],
                  );
                },
                transitionBuilder: (
                  Widget child,
                  Animation<double> animation,
                ) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(animation),
                    child: child,
                  );
                },
                child: Text(
                  texts[currentIndex],
                  key: ValueKey<String>(
                    texts[currentIndex],
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
}