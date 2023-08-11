import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../domain/entities/product_item.dart';
import 'bottom_sheet_to_cart.dart';

class ButtonAddProductToCart extends StatelessWidget {
  final double width;
  final ProductItem productItem;
  const ButtonAddProductToCart(
      {super.key, required this.productItem, required this.width});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cartBloc = context.watch<CartBloc>();
        final productId = productItem.productId;
        return InkWell(
          onTap: () {
            bottomSheetToCart(
              context: context,
              productItem: productItem,
            );
            if (cartBloc.isProductExit(productId)) {
              cartBloc.incrementProduct(productId: productId);
              return;
            }
            cartBloc.addProduct(
              productItem: productItem,
            );
          },
          child: Container(
            width: width,
            color: Colors.greenAccent,
            child: const Center(child: Text('Masuk Ke Keranjang')),
          ),
        );
      },
    );
  }
}
