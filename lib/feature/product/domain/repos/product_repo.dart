import '../../domain/entities/product_item.dart';

abstract class ProductRepo {
  Future<List<ProductItem>> getProductFromApi();
} 