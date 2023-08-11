// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductItem extends Equatable {
  final int productId;
  final String productName;
  final String description;
  final String distributor;
  final int productPrice;
  final List<String> urlImages;
  final String sourceItem;
  final String subTypeItem;
  final String typeItem;

  const ProductItem({
    required this.productId,
    required this.productName,
    required this.description,
    required this.distributor,
    required this.productPrice,
    required this.urlImages,
    required this.sourceItem,
    required this.subTypeItem,
    required this.typeItem,
  });

  ProductItem copyWith({
    int? productId,
    String? productName,
    String? description,
    String? distributor,
    int? productPrice,
    List<String>? urlImages,
    String? sourceItem,
    String? subTypeItem,
    String? typeItem,
  }) {
    return ProductItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      distributor: distributor ?? this.distributor,
      productPrice: productPrice ?? this.productPrice,
      urlImages: urlImages ?? this.urlImages,
      sourceItem: sourceItem ?? this.sourceItem,
      subTypeItem: subTypeItem ?? this.subTypeItem,
      typeItem: typeItem ?? this.typeItem,
    );
  }

  @override
  List<Object?> get props => [
        productId,
        description,
        distributor,
        sourceItem,
        subTypeItem,
        typeItem,
        productName,
        productPrice,
        urlImages
      ];
}
