import 'package:flutter/material.dart';

class CountProductInCartWidget extends StatelessWidget {
  final Widget countProductWidget;
  final void Function() onAdd;
  final void Function() onSubtract;
  const CountProductInCartWidget(
      {super.key,
      required this.countProductWidget,
      required this.onAdd,
      required this.onSubtract});

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width / 2;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.grey[900]!,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onAdd,
            child: const SizedBox(
              width: 50,
              child: Icon(Icons.add),
            ),
          ),
          // Text(countProduct.toString()),
          countProductWidget,
          InkWell(
            onTap: onSubtract,
            child: const SizedBox(
              width: 50,
              child: Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
  }
}
