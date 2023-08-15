import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/show_dialog/show_confirm_dialog.dart';

import '../../../cart/domain/entities/cart_product.dart';
import '../cubit/order_cubit.dart';

class ButtonOrderUserProduct extends StatefulWidget {
  final List<CartProduct> listCartProduct;
  const ButtonOrderUserProduct({
    super.key,
    required this.listCartProduct,
  });

  @override
  State<ButtonOrderUserProduct> createState() => _ButtonOrderUserProductState();
}

class _ButtonOrderUserProductState extends State<ButtonOrderUserProduct> {
  @override
  Widget build(BuildContext context) {
    final oderBloc = context.read<OrderCubit>();
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state == OrderState.ordered) {
          showConfirmDialog(
              context: context,
              trueFalseOption: false,
              message: oderBloc.message);
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
            ),
            onPressed: state == OrderState.loading
                ? null
                : () {
                    oderBloc.onCheckoutUserProduct(
                      listCartProduct: widget.listCartProduct,
                    );
                  },
            child: state == OrderState.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Text("Checkout Product"),
          ),
        );
      },
    );
  }
}
