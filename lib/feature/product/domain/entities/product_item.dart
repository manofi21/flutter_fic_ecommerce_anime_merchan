// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductItem extends Equatable {
  final int productId;
  final String productName;
  final int productPrice; 
  final List<String> urlImages;

  const ProductItem({required this.productId, required this.productName, required this.productPrice, this.urlImages = const []});

  ProductItem copyWith({
    String? productName,
    int? productPrice,
    List<String>? urlImages,
  }) {
    return ProductItem(
      productId: productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      urlImages: urlImages ?? this.urlImages,
    );
  }
  
  @override
  List<Object?> get props => [
    productId,
    productName,
    productPrice,
    urlImages
  ];
}
