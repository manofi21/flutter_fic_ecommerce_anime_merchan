import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';

import '../../feature/authentication/data/data_source/auth_local_data_source.dart';
import 'status_code_handler.dart';

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
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
      final response = data.body != null ? jsonDecode(data.body!) : {};
      final errorMessage = response['error'];
      if (errorMessage != null) {
        var resultError = errorMessage['message'];

        /// If "details" == null set "errors" Empty
        errorMessage["details"] ??= {"errors" : []};
        final getDetailErros = errorMessage["details"]["errors"];
        if (getDetailErros is List && getDetailErros.isNotEmpty) {
          for (Map msg in getDetailErros) {
            resultError += '\n - ${msg["message"]}';
          }
        }

        throw resultError;
      }

      final exception = statusCodeHandler(data.statusCode);
      if (exception != null) {
        throw exception;
      }
    
    return data;
  }
}