import 'package:flutter/material.dart';

class BaseGridView extends StatelessWidget {
  final ScrollPhysics? physics;
  final List<Widget> children;
  const BaseGridView({super.key, this.physics, required this.children});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2/3,
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
        ),
        itemCount: children.length,
        shrinkWrap: true,
        physics: physics,
        primary: true,
        itemBuilder: (BuildContext context, int index) {
          return children[index];
        },
    );
  }
}
