import 'package:equatable/equatable.dart';

import '../../../cart/domain/entities/cart_product.dart';

class OrderRequestEntities extends Equatable {
  final List<CartProduct> listCartProduct;
  final String deliveryAddress;
  final String courierName;
  final int shippingCost;

  const OrderRequestEntities({
    required this.listCartProduct,
    required this.deliveryAddress,
    required this.courierName,
    required this.shippingCost,
  });

  OrderRequestEntities copyWith({
    List<CartProduct>? listCartProduct,
    String? deliveryAddress,
    String? courierName,
    int? shippingCost,
  }) =>
      OrderRequestEntities(
        deliveryAddress: deliveryAddress ?? this.deliveryAddress,
        courierName: courierName ?? this.courierName,
        shippingCost: shippingCost ?? this.shippingCost,
        listCartProduct: listCartProduct ?? this.listCartProduct,
      );

  @override
  List<Object?> get props =>
      [listCartProduct, deliveryAddress, courierName, shippingCost];
}
