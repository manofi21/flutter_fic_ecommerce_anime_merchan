import 'package:flutter_fic_ecommerce_warung_comicon/core/errors/exceptions.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/errors/failure.dart';

import '../../domain/entities/product_item.dart';
import '../../domain/repos/product_repo.dart';
import '../data_source/product_remote_data_source.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductRemoteDataSource productRemoteDataSource;
  const ProductRepoImpl(this.productRemoteDataSource);

  @override
  Future<List<ProductItem>> getProductFromApi() async {
    try {
      final getProductList = await productRemoteDataSource.getProducts();
      final getValue = getProductList
          .map(
            (e) => ProductItem(
              productId: e.id, 
              description: e.attributes.description,
              productName: e.attributes.productName,
              productPrice: e.attributes.price,
              distributor: e.attributes.distributor,
              sourceItem: e.attributes.sourceItem.sourceItem,
              subTypeItem: e.attributes.subItemType.subItemType,
              typeItem: e.attributes.subItemType.itemType,
              quantity: e.attributes.quantity,
              urlImages: e.attributes.images.data
                  .map((e) => e.attributes.url)
                  .toList(),
            ),
          )
          .toList();
      return getValue;
    } on HttpException catch (e) { 
      throw ProductFailure(e.message);
    } on UnknownException catch (e) { 
      // throw UnknownFailure(e.message, stackTrace);
      throw ProductFailure(e.message);
    } catch (e, stackTrace) { 
      throw UnknownFailure('Occure in Product Repo : ${e.toString()}', stackTrace);
    }
  }
}
