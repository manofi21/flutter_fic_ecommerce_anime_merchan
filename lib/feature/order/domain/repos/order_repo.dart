import '../entities/order_request_entities.dart';
import '../entities/order_result_entities.dart';

abstract class OrderRepo {
  Future<OrderResultEntities> orderProduct(OrderRequestEntities orderRequest);
}