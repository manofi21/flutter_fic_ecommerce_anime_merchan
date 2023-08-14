import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/order_request_entities.dart';
import '../../domain/entities/order_result_entities.dart';
import '../../domain/repos/order_repo.dart';
import '../data_source/order_remote_data_source.dart';
import '../model/order_request_model.dart';

class OrderRepoImpl implements OrderRepo {
  final OrderRemoteDataSource orderRemoteDataSource;
  OrderRepoImpl(this.orderRemoteDataSource);

  @override
  Future<OrderResultEntities> orderProduct(
      OrderRequestEntities orderRequest) async {
    try {
      final listProduct = orderRequest.listCartProduct;
      final totalPriceList =
          listProduct.map((e) => e.priceAfterCalculated).toList();
      final modelCreateOrder = OrderRequestModel(
        items: listProduct
            .map((e) => Item(
                id: 0,
                productName: e.productItem.productName,
                price: e.productItem.productPrice,
                qty: e.productItemCount))
            .toList(),
        totalPrice: totalPriceList.reduce((v, e) => v + e).toInt(),
        deliveryAddress: orderRequest.deliveryAddress,
        courierName: orderRequest.courierName,
        shippingCost: orderRequest.shippingCost,
      );
      final orderProduct = await orderRemoteDataSource.createOrder(
        modelCreateOrder,
      );
      return orderProduct;
    } on HttpException catch (e) {
      throw OrderFailure(e.message);
    } on UnknownException catch (e) {
      throw OrderFailure(e.message);
    } catch (e, stackTrace) {
      throw UnknownFailure('Occure in Order Repo : ${e.toString()}', stackTrace);
    }
  }
}
