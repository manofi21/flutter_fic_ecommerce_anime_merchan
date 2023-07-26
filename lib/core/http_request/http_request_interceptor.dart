import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';

import '../../feature/authentication/data/data_source/auth_local_data_source.dart';

class HttpRequestInterceptor implements InterceptorContract {
  final AuthLocalDataSource authStorage;
  HttpRequestInterceptor(this.authStorage);

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    if (data.method == Method.GET) {
      final getToken = await authStorage.getAccessToken();
      data.headers[HttpHeaders.authorizationHeader] = "Bearer $getToken"; 
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>  data;
}