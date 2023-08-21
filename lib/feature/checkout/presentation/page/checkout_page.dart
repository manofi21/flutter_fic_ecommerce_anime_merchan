import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/checkout/presentation/widget/list_checkout_item_widget.dart';
import '../bloc/address_checkout/address_checkout_bloc.dart';
import '../widget/address_checkout_widget.dart';
import '../widget/checkout_order_button.dart';
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
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        actions: const [],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height -
                (45 + appBarHeight + statusBarHeight + 15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    AddressCheckoutBlocBuilder(),
                    ListCheckoutItemBlocBuilder(),
                    SubtotalCheckoutItemWidget()
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: CheckoutOrderButton(),
          ),
        ],
      ),
    );
  }
}
