import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/http_request/is_token_expired.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/show_dialog/show_error_dialog.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/presentation/page/auth_page.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../feature/authentication/data/data_source/auth_local_data_source.dart';
import '../errors/exceptions.dart';
import '../navigator/navigator.dart';
import 'status_code_handler.dart';

class HttpRequestInterceptor implements InterceptorContract {
  final AuthLocalDataSource authStorage;
  HttpRequestInterceptor(this.authStorage);

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    final getToken = await authStorage.getAccessToken();
    final currentRequest = data.url;
    final apiWithoutCheckAPI = ['/api/auth/local', '/api/auth/local/register'];

    if ((getToken ?? '').isEmpty &&
        !apiWithoutCheckAPI.any((e) => currentRequest.contains(e))) {
      throw const NoTokenSaved();
    }

    if (data.method == Method.GET) {
      data.headers[HttpHeaders.authorizationHeader] = "Bearer $getToken";
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    final response = data.body != null ? jsonDecode(data.body!) : {};
    final errorMessage = response['error'];

    final isExpired = isTokenExpired(data.statusCode);
    if (errorMessage != null && !isExpired) {
      var resultError = errorMessage['message'];

      /// If "details" == null set "errors" Empty
      errorMessage["details"] ??= {"errors": []};
      final getDetailErros = errorMessage["details"]["errors"];
      if (getDetailErros is List && getDetailErros.isNotEmpty) {
        for (Map msg in getDetailErros) {
          resultError += '\n - ${msg["message"]}';
        }
      }

      throw resultError;
    }

    final exception = statusCodeHandler(data.statusCode);

    if (isExpired && exception != null) {
      final context = navigatorKey.currentContext!;
      await showErrorDialog(context: context, message: exception.message).then(
        (value) {
          authStorage.clearToken();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const AuthPage(),
            ),
          );
        },
      );
    }

    if (exception != null) {
      throw exception;
    }

    return data;
  }
}
