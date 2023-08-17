import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base_widget/price_text_widget.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';

class SubtotalCheckoutItemWidget extends StatelessWidget {
  const SubtotalCheckoutItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    final checkedList = cartBloc.checkedList();
    return Card(
      child: ExpansionTile(
        collapsedTextColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Subtotal"),
            Text(cartBloc.getAllTotalCheckPriceProduct())
          ],
        ),
        children: [
          for (var i = 0; i < checkedList.length; i++) ...{
            if ((i + 1) % 2 == 0) const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Harga (${checkedList[i].productItemCount} Barang)"),
                  PriceTextWidget(
                    price: checkedList[i].priceAfterCalculated,
                    textStyle: const TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
            if ((i + 1) % 2 == 0) const SizedBox(height: 5),
          }
        ],
      ),
    );
  }
}
