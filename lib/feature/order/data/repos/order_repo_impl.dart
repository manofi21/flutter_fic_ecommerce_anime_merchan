import 'package:flutter_fic_ecommerce_warung_comicon/feature/order/data/model/order_request_model.dart';

import '../../domain/entites/order_request_model.dart';
import '../../domain/repos/order_repo.dart';
import '../data_source/order_remote_data_source.dart';

class OrderRepoImpl implements OrderRepo {
  final OrderRemoteDataSource orderRemoteDataSource;
  OrderRepoImpl(this.orderRemoteDataSource);

  @override
  Future<void> orderProduct(OrderRequestEntities orderRequest) async {
    final listProduct = orderRequest.listCartProduct;
    final totalPriceList = listProduct.map((e) => e.priceAfterCalculated).toList();
    final modelCreateOrder = OrderRequestModel(items: listProduct.map((e) => Item(id: 0, productName: e.productItem.productName, price: e.productItem.productPrice, qty: e.productItemCount)).toList(), totalPrice: totalPriceList.reduce((v, e) => v + e).toInt(), deliveryAddress: "Nama Alamat", courierName: "Nama Courier", shippingCost: 20000);
    final orderProduct = await orderRemoteDataSource.createOrder(modelCreateOrder);
  }
}
