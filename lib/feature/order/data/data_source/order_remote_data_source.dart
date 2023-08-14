import 'package:http_interceptor/http/intercepted_http.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/http_request/remote_data_request.dart';
import '../model/order_request_model.dart';
import '../model/order_result_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderResultModel> createOrder(OrderRequestModel orderRequest);
}

class OrderRemoteDataSourceImpl extends RemoteDataRequest
    implements OrderRemoteDataSource {
  OrderRemoteDataSourceImpl({
    required InterceptedHttp http,
  }) : super(http: http);

  @override
  Future<OrderResultModel> createOrder(OrderRequestModel orderRequest) async {
    try {
      final orderResult = await postRequest<OrderResultModel>(
        '/api/orders',
        useEncode: true,
        fromMap: OrderResultModel.fromJson,
        bodyParameter: {
          "data": orderRequest.toJson(),
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
