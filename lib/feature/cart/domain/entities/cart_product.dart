import 'package:equatable/equatable.dart';

import '../../../product/domain/entities/product_item.dart';

class CartProduct extends Equatable{
  final ProductItem productItem;
  final int productItemCount;
  final double priceAfterCalculated;
  final bool isChecked;

  const CartProduct({required this.productItem, this.productItemCount = 0, this.priceAfterCalculated = 0, this.isChecked = true});

  CartProduct copyWith({
    ProductItem? productItem,
    int? productItemCount,
    double? priceAfterCalculated,
    bool? isChecked,
  }) {
    return CartProduct(
      productItem: productItem ?? this.productItem,
      productItemCount: productItemCount ?? this.productItemCount,
      priceAfterCalculated: priceAfterCalculated ?? this.priceAfterCalculated,
      isChecked: isChecked ?? this.isChecked,
    );
  }
  
  @override
  List<Object?> get props => [
    productItem,
    productItemCount,
    priceAfterCalculated,
    isChecked,
  ];
}