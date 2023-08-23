import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/checkout_order_request_entities.dart';
import '../../domain/entities/checkout_order_result_entities.dart';
import '../../domain/repos/checkout_order_repo.dart';
import '../data_source/checkout_order_remote_data_source.dart';
import '../model/checkout_order_request_model.dart';

class CheckoutOrderRepoImpl implements CheckoutOrderRepo {
  final CheckoutOrderRemoteDataSource checkoutOrderRemoteDataSource;
  CheckoutOrderRepoImpl(this.checkoutOrderRemoteDataSource);

  @override
  Future<OrderResultEntities> orderProduct(
      OrderRequestEntities orderRequest) async {
    try {
      final listProduct = orderRequest.listCartProduct;
      final totalPriceList =
          listProduct.map((e) => e.priceAfterCalculated).toList();
      final modelCreateOrder = CheckoutOrderRequestModel(
        items: listProduct.map((e) {
          final urlImageList = e.productItem.urlImages;

          return Item(
            id: e.productItem.productId,
            productName: e.productItem.productName,
            price: e.productItem.productPrice,
            qty: e.productItemCount,
            urlImage: urlImageList.isEmpty
                ? ""
                : (urlImageList.first.urlSmallImage ??
                    urlImageList.first.urlImage),
          );
        }).toList(),
        totalPrice: totalPriceList.reduce((v, e) => v + e).toInt(),
        deliveryAddress: orderRequest.deliveryAddress,
        courierName: orderRequest.courierName,
        shippingCost: orderRequest.shippingCost,
      );
      final orderProduct = await checkoutOrderRemoteDataSource.createOrder(
        modelCreateOrder,
      );
      return orderProduct;
    } on HttpException catch (e) {
      throw OrderCheckoutFailure(e.message);
    } on UnknownException catch (e) {
      throw OrderCheckoutFailure(e.message);
    } catch (e, stackTrace) {
      throw UnknownFailure(
          'Occure in Order Repo : ${e.toString()}', stackTrace);
    }
  }
}
