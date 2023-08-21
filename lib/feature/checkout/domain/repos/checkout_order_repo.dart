import '../entities/checkout_order_request_entities.dart';
import '../entities/checkout_order_result_entities.dart';

abstract class CheckoutOrderRepo {
  Future<OrderResultEntities> orderProduct(OrderRequestEntities orderRequest);
}