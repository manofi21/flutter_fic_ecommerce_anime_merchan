import 'package:flutter_fic_ecommerce_warung_comicon/feature/order_history/data/extension/order_status_to_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/order_history_entity.dart';
import '../../domain/repos/order_history_repo.dart';
import '../data_source/order_history_remote_data_source.dart';

class OrderHistoryRepoImpl implements OrderHistoryRepo {
  final OrderHistoryRemoteDataSource orderHistoryRemoteDataSource;
  OrderHistoryRepoImpl(this.orderHistoryRemoteDataSource);

  @override
  Future<List<OrderHistoryEntity>> orderToHistoryEntities() async {
    try {
      final listOrderHistory =
          await orderHistoryRemoteDataSource.userHistoryOrder();
      final listOrderHistoryToEntities = listOrderHistory
          .map(
            (e) => OrderHistoryEntity(
              id: e.id,
              items: e.items
                  .map(
                    (e) => Item(
                      productName: e.productName,
                      price: e.price,
                      qty: e.qty,
                    ),
                  )
                  .toList(),
              totalPrice: e.totalPrice,
              deliveryAddress: e.deliveryAddress,
              courierName: e.courierName,
              shippingCost: e.shippingCost,
              orderStatus: e.orderStatus.toOrderStatusEntity,
              urlPayment: e.urlPayment,
            ),
          )
          .toList();
      return listOrderHistoryToEntities;
    } on HttpException catch (e) {
      throw OrderHistoryFailure(e.message);
    } on UnknownException catch (e) {
      throw OrderHistoryFailure(e.message);
    } catch (e, stackTrace) {
      throw UnknownFailure(
          'Occure in Order Repo : ${e.toString()}', stackTrace);
    }
  }
}
