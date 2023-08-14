import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import '../constant/constant.dart';
import '../errors/exceptions.dart';

abstract class RemoteDataRequest {
  final InterceptedHttp http;
  RemoteDataRequest({required this.http});

  Uri baseUri(String path, [Map<String, dynamic>? queryParameters]) =>
      Uri.https(baseUrl, path, queryParameters);

  Future<T> getRequest<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic> map) fromMap,
  }) async {
    try {
      final urlRequest = baseUri(path);
      final response = await http.get(urlRequest, params: queryParameters);
      final resultDecode = jsonDecode(response.body);
      final mapValue = fromMap(resultDecode);
      return mapValue;
    } on BaseExceptions {
      rethrow;
    } catch (e) {
      throw HttpException(
          'Occure in Remote Date Requst(Get) : ${e.toString()}');
    }
  }

  Future<T> postRequest<T>(
    String path, {
    bool useEncode = false,
    Map<String, dynamic>? bodyParameter,
    Map<String, String>? headerParameter,
    required T Function(Map<String, dynamic> map) fromMap,
  }) async {
    try {
      final urlRequest = baseUri(path);
      final response = await http.post(
        urlRequest,
        body: useEncode ? json.encode(bodyParameter) : bodyParameter,
        headers: headerParameter,
      );

      final resultDecode = jsonDecode(response.body);
      final mapValue = fromMap(resultDecode);
      return mapValue;
    } on BaseExceptions {
      rethrow;
    } catch (e) {
      throw HttpException(
          'Occure in Remote Date Requst(Post) : ${e.toString()}');
    }
  }
}
