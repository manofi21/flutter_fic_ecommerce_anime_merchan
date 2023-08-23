import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/show_dialog/show_confirm_dialog.dart';

class PaymentInformationWidget extends StatefulWidget {
  final bool isSuccess;
  const PaymentInformationWidget({super.key, required this.isSuccess});

  @override
  State<PaymentInformationWidget> createState() =>
      _PaymentInformationWidgetState();
}

class _PaymentInformationWidgetState extends State<PaymentInformationWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        var message = widget.isSuccess ? "Transaksi Berhasil" : "Transaksi Gagal"; 
        showConfirmDialog(context: context, message: message, trueFalseOption: false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Overlay()));
  }
}
