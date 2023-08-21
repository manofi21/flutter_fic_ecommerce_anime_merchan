import 'package:flutter/material.dart';
import '../../../checkout/presentation/page/checkout_page.dart';

class ToCheckoutButton extends StatelessWidget {
  const ToCheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CheckoutPage(),
              ),
            );
          },
          child: const Text("Checkout Product"),
        ),
      );
  }
}