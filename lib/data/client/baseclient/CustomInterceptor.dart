import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_5240_frontend/utils/local_store.dart';

class CustomInterceptor extends Interceptor {
  String url;

  CustomInterceptor(this.url);
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.baseUrl = url;
    options.connectTimeout = const Duration(seconds: 60);
    options.receiveTimeout = const Duration(minutes: 2);
    options.followRedirects = false;
    options.validateStatus = (status) {
      return status! < 500;
    };
    try {
      String? token = await LocalStore.getToken();
      if (token != null) {
        options.headers['Authorization'] = "Bearer $token";
        debugPrint('*** API Request - Start ***');

        debugPrint('URI ${options.uri}');
        debugPrint('METHOD: ${options.method}');
        debugPrint('HEADERS:');
        options.headers.forEach((key, v) => debugPrint(' - $key,  $v'));
        debugPrint('BODY:');
        debugPrint(options.data ?? '');

        debugPrint('*** API Request - End ***');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    handler.next(options);
  }
}
