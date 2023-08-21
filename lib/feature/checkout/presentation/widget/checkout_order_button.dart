import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/order_checkout/order_checkout_cubit.dart';
import '../page/payment_page.dart';

class CheckoutOrderButton extends StatelessWidget {
  const CheckoutOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCheckoutCubit, OrderCheckoutState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            onPressed: state.isLoading
                ? null
                : () {
                    context.read<OrderCheckoutCubit>().onCheckoutUserProduct(
                      onSuccessOrder: (urlPayment) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PaymentPage(paymentUrl: urlPayment),
                          ),
                        );
                      },
                    );
                  },
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : const Text("Checkout"),
          ),
        );
      },
    );
  }
}
