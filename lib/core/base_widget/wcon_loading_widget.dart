
import 'package:flutter/material.dart';

class WConLodingWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final bool show;

  const WConLodingWidget({super.key, 
    required this.child,
    this.title = "Loading ...",
    this.show = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: <Widget>[
          child,
          IgnorePointer(
            ignoring: !show,
            child: Opacity(
              opacity: show ? 1.0 : 0.0,
              child: Container(
                width: screenSize.width,
                height: screenSize.height,
                alignment: Alignment.center,
                color: const Color.fromARGB(100, 0, 0, 0),
                child: MyLoadingView(title: title),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MyLoadingView extends StatelessWidget {
  final String title;
  final Color textColor;
  final FontWeight fontWeight;

  const MyLoadingView({
    Key? key,
    this.title = "Loading...",
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const CircularProgressIndicator(),
        const SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
