import 'package:bloc/bloc.dart';

import '../../../../cart/domain/entities/cart_product.dart';
import '../../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../domain/entities/checkout_order_request_entities.dart';
import '../../../domain/use_cases/checkout_order_product.dart';
part 'order_checkout_state.dart';

class OrderCheckoutCubit extends Cubit<OrderCheckoutState> {
  final CheckoutOrderProduct checkoutOrder;
  final CartBloc? cartBloc;
  OrderCheckoutCubit(this.checkoutOrder, {this.cartBloc}) : super(OrderCheckoutState.initial);

  var message = '';
  var orderLink = '';

  Future<void> onCheckoutUserProduct({
    List<CartProduct> listCartProduct = const [],
    required void Function(String) onSuccessOrder,
  }) async {
    emit(OrderCheckoutState.loading);
    final getSelectedProduct = cartBloc?.checkedList() ?? listCartProduct;
    final getCheckout = await checkoutOrder(
      OrderRequestEntities(
        listCartProduct: getSelectedProduct,
        deliveryAddress: 'Delivery Address',
        courierName: 'Courier Name',
        shippingCost: 20000,
      ),
    );

    orderLink = '';
    message = '';

    final getOrderState = getCheckout.when<OrderCheckoutState>(
      ok: (ok) {
        orderLink = ok.redirectUrl;
        message = 'Segera Proses Pembayaran.';
        return OrderCheckoutState.ordered;
      },
      err: (err) {
        message = err.message;
        return OrderCheckoutState.error;
      },
    );

    cartBloc?.clearOrderedCartList();

    if (getOrderState == OrderCheckoutState.ordered) {
      onSuccessOrder(orderLink);
    }

    emit(getOrderState);
  }
}
