import 'package:flutter/material.dart';

class CheckboxCart extends StatefulWidget {
  final bool onValueChecked;
  final void Function(bool) onChanged;
  const CheckboxCart(
      {super.key, required this.onValueChecked, required this.onChanged});

  @override
  State<CheckboxCart> createState() => _CheckboxCartState();
}

class _CheckboxCartState extends State<CheckboxCart> {
  late bool currentValue;

  @override
  void initState() {
    super.initState();

    currentValue = widget.onValueChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: currentValue,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      onChanged: (clicked) {
        widget.onChanged(clicked ?? false);
        setState(() {
          currentValue = clicked ?? false;
        });
      },
    );
  }
}
