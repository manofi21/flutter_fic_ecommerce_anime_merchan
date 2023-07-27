// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductItem extends Equatable {
  final String productName;
  final int productPrice; 
  final List<String> urlImages;

  const ProductItem({required this.productName, required this.productPrice, this.urlImages = const []});

  ProductItem copyWith({
    String? productName,
    int? productPrice,
    List<String>? urlImages,
  }) {
    return ProductItem(
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      urlImages: urlImages ?? this.urlImages,
    );
  }
  
  @override
  List<Object?> get props => [
    productName,
    productPrice,
    urlImages
  ];
}
