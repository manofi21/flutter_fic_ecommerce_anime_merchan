import 'package:flutter/material.dart';

import '../../../../core/base_widget/base_grid_view_widget.dart';
import '../../domain/entities/product_item.dart';
import 'card_product.dart';

Widget gridProductView(BuildContext context, {List<ProductItem> listProduct = const []}) {
  return BaseGridView(
      physics: const NeverScrollableScrollPhysics(),
      children: listProduct.map((e) => CardProduct(productItem: e)).toList(),
    );
}