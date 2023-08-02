import 'package:equatable/equatable.dart';

import '../../product/domain/entities/product_item.dart';

class CartProduct extends Equatable{
  final ProductItem productItem;
  final int productItemCount;
  final double priceAfterCalculated;

  const CartProduct({required this.productItem, this.productItemCount = 0, this.priceAfterCalculated = 0});

  CartProduct copyWith({
    ProductItem? productItem,
    int? productItemCount,
    double? priceAfterCalculated,
  }) {
    return CartProduct(
      productItem: productItem ?? this.productItem,
      productItemCount: productItemCount ?? this.productItemCount,
      priceAfterCalculated: priceAfterCalculated ?? this.priceAfterCalculated,
    );
  }
  
  @override
  List<Object?> get props => [
    productItem,
    productItemCount,
    priceAfterCalculated,
  ];
}