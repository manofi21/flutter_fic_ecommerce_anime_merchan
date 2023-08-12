
import '../entites/order_request_model.dart';

abstract class OrderRepo {
  Future<void> orderProduct(OrderRequestEntities orderRequest);
}