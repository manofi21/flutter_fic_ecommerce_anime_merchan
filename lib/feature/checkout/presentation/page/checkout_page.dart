import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/checkout/presentation/bloc/address_checkout_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/checkout/presentation/widget/list_checkout_item_widget.dart';
import '../widget/address_checkout_widget.dart';
import '../widget/subtotal_checkout_item_widget.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final addressCheckoutBloc = context.read<AddressCheckoutBloc>();
        addressCheckoutBloc.add(AddressGetCheckoutEvent());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: const [
              AddressCheckoutBlocBuilder(),
              ListCheckoutItemBlocBuilder(),
              SubtotalCheckoutItemWidget()
            ],
          ),
        ),
      ),
    );
  }
}
