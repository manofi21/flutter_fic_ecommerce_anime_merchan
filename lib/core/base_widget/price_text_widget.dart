import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PriceTextWidget extends StatelessWidget {
  final double price;
  PriceTextWidget({super.key, required this.price});

  final idrFormatter = CurrencyFormatterSettings(
    symbol: 'Rp',
    thousandSeparator: '.',
    decimalSeparator: ',',
  );

  @override
  Widget build(BuildContext context) {
    final stringCurrency =
        CurrencyFormatter.format(price, idrFormatter, decimal: 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stringCurrency,
          style: TextStyle(
              color: Colors.black12,
              fontSize: 9.sp,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
