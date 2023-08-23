import 'package:http_interceptor/http/intercepted_http.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/http_request/remote_data_request.dart';
import '../model/order_history_user_model.dart';

abstract class OrderHistoryRemoteDataSource {
  Future<List<OrderHistoryUserModel>> userHistoryOrder();
}

class OrderHistoryRemoteDataSourceImpl extends RemoteDataRequest
    implements OrderHistoryRemoteDataSource {
  OrderHistoryRemoteDataSourceImpl({
    required InterceptedHttp http,
  }) : super(http: http);

  @override
  Future<List<OrderHistoryUserModel>> userHistoryOrder() async {
    try {
      final orderResult = await getRequest<List<OrderHistoryUserModel>>(
        '/api/orders',
        fromMap: (result) {
          final getList = result["data"];
          if (getList is List) {
            return getList.map((e) => OrderHistoryUserModel.fromJson(e)).toList();
          }
          return [];
        },
      );
      return orderResult;
    } on HttpException {
      rethrow;
    } catch (e, stackTrace) {
      throw UnknownException(
        'Occure in Order Remote Data Source(createOrder) : ${e.toString()}',
        stackTrace,
      );
    }
  }
}
