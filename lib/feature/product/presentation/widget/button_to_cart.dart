import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/widget/count_product_in_cart_widget.dart';
import '../../domain/entities/product_item.dart';

class ButtonToCart extends StatelessWidget {
  final ProductItem productItem;
  const ButtonToCart({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cartBloc = context.watch<CartBloc>();
        final productId = productItem.productId;
        Widget? buttonWidget;

        if (cartBloc.isProductExit(productId)) {
          final productInCart = cartBloc.countProductInCart(productId);
          buttonWidget = CountProductInCartWidget(
            countProductWidget: Text(productInCart.toString()),
            onAdd: () {
              cartBloc.incrementProduct(productId: productId);
            },
            onSubtract: () {
              cartBloc.decrementProduct(productId: productId);
            },
          );
        }

        buttonWidget ??= ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
          ),
          onPressed: () {
            cartBloc.addProduct(
              productItem: productItem,
            );
          },
          child: const Text("Ke Keranjang"),
        );

        return SizedBox(
            height: 40, width: double.infinity, child: buttonWidget);
      },
    );
  }
}
