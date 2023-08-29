import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/checkout/presentation/widget/checkout_payment_webview_widget.dart';

class PaymentPage extends StatelessWidget {
  final String paymentUrl;
  final bool isDoublePop;
  const PaymentPage(
      {super.key, required this.paymentUrl, this.isDoublePop = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            if (isDoublePop) {
              for (int i = 0; i < 2; i++) {
                Navigator.pop(context);
              }
            }

            if (!isDoublePop) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: CheckoutWebview(
        link: paymentUrl,
      ),
    );
  }
}
