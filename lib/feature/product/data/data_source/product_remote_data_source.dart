import 'package:http_interceptor/http_interceptor.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/http_request/remote_data_request.dart';
import '../modal/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProducts();
}

class ProductRemoteDataSourceImpl extends RemoteDataRequest
    implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({
    required InterceptedHttp http,
  }) : super(http: http);

  @override
  Future<List<Product>> getProducts() async {
    try {
      final getProductResult = await getRequest<List<Product>>(
        '/api/products',
        queryParameters: {'populate': '*'},
        fromMap: (e) {
          final getData = e['data'];
          if (getData is List) {
            final listResut = getData.map(Product.fromJson).toList();
            return listResut;
          }
          return [];
        },
      );

      return getProductResult;
    } on HttpException {
      rethrow;
    } catch (e) {
      throw UnknownException(
          'Occure in Product Remote Data Source : ${e.toString()}');
    }
  }
}
