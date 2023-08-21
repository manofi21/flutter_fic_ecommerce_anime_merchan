import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
      NavigationDelegate(),
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
