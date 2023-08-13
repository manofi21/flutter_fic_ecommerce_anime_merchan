import 'package:bloc/bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/order/domain/entities/order_request_entities.dart';

import '../../../cart/domain/entities/cart_product.dart';
import '../../domain/use_cases/checkout_order_product.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final ChecoutOrderProduct checkoutOrder;
  OrderCubit(this.checkoutOrder) : super(OrderState.initial);

  var message = '';
  var orderLink = '';

  Future<void> onCheckoutUserProduct(
      {List<CartProduct> listCartProduct = const []}) async {
    emit(OrderState.loading);
    final getCheckout = await checkoutOrder(
      OrderRequestEntities(
        listCartProduct: listCartProduct,
        deliveryAddress: 'Delivery Address',
        courierName: 'Courier Name',
        shippingCost: 20000,
      ),
    );

    final getOrderState = getCheckout.when<OrderState>(
      ok: (ok) {
        orderLink = ok.redirectUrl;
        message = 'Segerap Proses Pembayaran';
        return OrderState.ordered;
      },
      err: (err) {
        message = err.message;
        return OrderState.error;
      },
    );

    emit(getOrderState);
  }
}
