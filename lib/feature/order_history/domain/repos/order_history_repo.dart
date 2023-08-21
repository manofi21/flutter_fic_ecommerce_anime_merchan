import '../entities/order_history_entity.dart';

abstract class OrderHistoryRepo {
  Future<List<OrderHistoryEntity>> orderToHistoryEntities();
}