// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductItem extends Equatable {
  final String productName;

  const ProductItem({required this.productName});

  ProductItem copyWith({
    String? productName,
  }) {
    return ProductItem(
      productName: productName ?? this.productName,
    );
  }
  
  @override
  List<Object?> get props => [
    productName
  ];
}
