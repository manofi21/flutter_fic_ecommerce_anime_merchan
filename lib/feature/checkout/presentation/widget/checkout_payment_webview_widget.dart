import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/checkout/presentation/widget/payment_information_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutWebview extends StatefulWidget {
  final String link;
  const CheckoutWebview({super.key, required this.link});

  @override
  State<CheckoutWebview> createState() => _CheckoutWebviewState();
}

class _CheckoutWebviewState extends State<CheckoutWebview> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setNavigationDelegate(
      NavigationDelegate(
          onPageStarted: (url) {
            print('urlStatus : $url');
            if (url.contains('status_code')) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      PaymentInformationWidget(isSuccess: url.contains('=200')),
                ),
              );
            }
          },
          onUrlChange: (url) {}),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.loadRequest(
        Uri.parse(widget.link),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final gestureRecognizers = {Factory(() => EagerGestureRecognizer())};

    return WebViewWidget(
      controller: _controller,
      gestureRecognizers: gestureRecognizers,
    );
  }
}
