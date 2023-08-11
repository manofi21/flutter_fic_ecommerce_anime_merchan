import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


Future<Object?> showBaseBottomSheet({
  required BuildContext currentcontext,
  // required Widget Function(BuildContext context) builder,
  required Widget builder,
  EdgeInsetsGeometry padding = const EdgeInsets.all(20),
  bool isDismissible = true,
}) async {
  return showModalBottomSheet(
    context: currentcontext,
    elevation: 10,
    isScrollControlled: true,
    isDismissible: isDismissible,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(5.sp),
      ),
    ),
    builder: (_) {
      return AnimatedPadding(
        padding: MediaQuery.of(currentcontext).viewInsets / 3.5,
        duration: const Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: Padding(
          padding: padding,
          child: builder,
        ),
      );
    },
  );
}
