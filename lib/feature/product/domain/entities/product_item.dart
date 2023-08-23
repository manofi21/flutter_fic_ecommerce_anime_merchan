// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductItem extends Equatable {
  final int productId;
  final String productName;
  final String description;
  final String distributor;
  final int productPrice;
  final List<UrlImageProduct> urlImages;
  final String sourceItem;
  final String subTypeItem;
  final String typeItem;
  final int quantity;

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
    required this.quantity,
  });

  ProductItem copyWith(
      {int? productId,
      String? productName,
      String? description,
      String? distributor,
      int? productPrice,
      List<UrlImageProduct>? urlImages,
      String? sourceItem,
      String? subTypeItem,
      String? typeItem,
      int? quantity}) {
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
      quantity: quantity ?? this.quantity,
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
        urlImages,
        quantity,
      ];
}

class UrlImageProduct extends Equatable {
  final String urlImage;
  final String? urlSmallImage;

  const UrlImageProduct({
    required this.urlImage,
    required this.urlSmallImage,
  });

  UrlImageProduct copyWith({
    String? urlImage,
    String? urlSmallImage,
  }) {
    return UrlImageProduct(
      urlImage: urlImage ?? this.urlImage,
      urlSmallImage: urlSmallImage ?? this.urlSmallImage,
    );
  }

  @override
  List<Object?> get props => [urlImage, urlSmallImage];
}
