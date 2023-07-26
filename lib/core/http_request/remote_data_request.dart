import 'dart:convert';

import 'package:flutter_fic_ecommerce_warung_comicon/core/http_request/status_code_handler.dart';
// import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import '../constant/constant.dart';
import '../errors/exceptions.dart';

abstract class RemoteDataRequest {
  final InterceptedHttp http;
  RemoteDataRequest({required this.http});
  
  Uri baseUri(String path, [Map<String, dynamic>? queryParameters]) =>
      Uri.http(baseUrl, path, queryParameters);

  Future<T> getRequest<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic> map) fromMap,
  }) async {
    try {
      final urlRequest = baseUri(path, queryParameters);
      final response = await http.get(urlRequest);
      final exception = statusCodeHandler(response.statusCode);
      if (exception != null) {
        throw exception;
      }

      final resultDecode = jsonDecode(response.body);
      final mapValue = fromMap(resultDecode);
      return mapValue;
    } on HttpException {
      rethrow;
    } catch (e) {
      throw HttpException('Occure in Remote Date Requst(Get) : ${e.toString()}');
    }
  }

  Future<T> postRequest<T>(
    String path, {
    Map<String, dynamic>? bodyParameter,
    Map<String, String>? headerParameter,
    required T Function(Map<String, dynamic> map) fromMap,
  }) async {
    try {
      final urlRequest = baseUri(path);
      final response = await http.post(
        urlRequest,
        body: bodyParameter,
        headers: headerParameter,
      );
      final exception = statusCodeHandler(response.statusCode);
      if (exception != null) {
        throw exception;
      }

      final resultDecode = jsonDecode(response.body);
      final mapValue = fromMap(resultDecode);
      return mapValue;
    } on HttpException {
      rethrow;
    } catch (e) {
      throw HttpException('Occure in Remote Date Requst(Post) : ${e.toString()}');
    }
  }
}
