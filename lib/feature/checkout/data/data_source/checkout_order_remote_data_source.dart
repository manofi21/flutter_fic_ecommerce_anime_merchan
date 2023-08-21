import 'package:http_interceptor/http/intercepted_http.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/http_request/remote_data_request.dart';
import '../model/checkout_order_request_model.dart';
import '../model/checkout_order_result_model.dart';

abstract class CheckoutOrderRemoteDataSource {
  Future<CheckoutOrderResultModel> createOrder(CheckoutOrderRequestModel orderRequest);
}

class CheckoutOrderRemoteDataSourceImpl extends RemoteDataRequest
    implements CheckoutOrderRemoteDataSource {
  CheckoutOrderRemoteDataSourceImpl({
    required InterceptedHttp http,
  }) : super(http: http);

  @override
  Future<CheckoutOrderResultModel> createOrder(CheckoutOrderRequestModel orderRequest) async {
    try {
      final orderResult = await postRequest<CheckoutOrderResultModel>(
        '/api/orders',
        useEncode: true,
        fromMap: CheckoutOrderResultModel.fromJson,
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
