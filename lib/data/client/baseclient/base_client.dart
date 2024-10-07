// ignore_for_file: constant_identifier_names, non_constant_identifier_names, unnecessary_new, unrelated_type_equality_checks

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_5240_frontend/data/client/baseclient/CustomInterceptor.dart';
import 'package:project_5240_frontend/data/client/baseclient/app_exceptions.dart';
import 'package:project_5240_frontend/utils/local_store.dart';

class BaseClient {
  static late String baseUrl;
  static Dio dio = Dio();

  // Initialize with base URL and load the auth token from storage
  static Future<void> initialize(String url) async {
    baseUrl = url;
    dio = Dio();
    dio.interceptors.add(CustomInterceptor(url));
  }

  // GET request
  static Future<Response<dynamic>?> get({String? api}) async {
    try {
      var response = await dio.get(api ?? "");
      return response;
    } on DioException catch (e) {
      if (e.type == DioException.connectionTimeout) {
        throw ApiNotRespondingException("Connection Timeout");
      } else if (e.type == DioException.receiveTimeout) {
        throw ApiNotRespondingException("Connection Timeout");
      } else if (e.type == DioException.connectionError) {
        throw ApiNotRespondingException("No Internet Connection");
      } else if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
      } else {
        debugPrint(e.requestOptions.headers.toString());
        debugPrint(e.toString());
      }
    } catch (e) {
      throw ApiNotRespondingException(e.toString());
    }
    return null;
  }

  static Future<Response<dynamic>?> getById({String? api, String? id}) async {
    try {
      var response = await dio.get(
        api ?? "",
        options: Options(
          headers: {
            "x-business-id": id ?? "",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      if (e.type == DioException.connectionTimeout) {
        throw ApiNotRespondingException("Connection Timeout");
      } else if (e.type == DioException.receiveTimeout) {
        throw ApiNotRespondingException("Connection Timeout");
      } else if (e.type == DioException.connectionError) {
        throw ApiNotRespondingException("No Internet Connection");
      } else if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
      } else {
        debugPrint(e.requestOptions.headers.toString());
        debugPrint(e.toString());
      }
    } catch (e) {
      throw ApiNotRespondingException(e.toString());
    }
    return null;
  }

  // POST request
  static Future<dynamic> post({
    String? api,
    Map<String, dynamic>? payloadObj,
    FormData? formData,
    Map<String, dynamic>? queryParams,
  }) async {
    // Make the request
    try {
      var response = await dio.post(
        api ?? "",
        data: payloadObj ?? formData ?? {}, // Use either payloadObj or formData
        queryParameters: queryParams ?? {}, // Add query parameters if provided
      );
      debugPrint("Post statusCode ======>${response.statusCode}");
      return response;
    } on DioException catch (e) {
      if (e.type == DioException.connectionTimeout) {
        ApiNotRespondingException("Connection Timeout");
      } else if (e.type == DioException.receiveTimeout) {
        ApiNotRespondingException("Connection Timeout");
      } else if (e.type == DioException.connectionError) {
        ApiNotRespondingException("No Internet Connection");
      } else if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
      } else {
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
      }
    }
  }

  // PUT request
  static Future<dynamic> put({
    String? api,
    dynamic payloadObj,
    FormData? formData,
    Map<String, dynamic>? queryParams,
  }) async {
    var uri = baseUrl + (api ?? "");
    debugPrint("PUT Url============> $uri");
    try {
      var response = await dio.put(
        uri,
        data: payloadObj ?? formData ?? {}, // Use either payloadObj or formData
        queryParameters: queryParams ?? {}, // Add query parameters if provided
      );
      return response;
    } on DioException catch (e) {
      if (e.type == DioException.connectionTimeout) {
        ApiNotRespondingException("Connection Timeout");
      } else if (e.type == DioException.receiveTimeout) {
        ApiNotRespondingException("Connection Timeout");
      } else if (e.type == DioException.connectionError) {
        ApiNotRespondingException("No Internet Connection");
      } else if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
      } else {
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
      }
    }
    return null;
  }

  // DELETE request
  static Future<dynamic> delete({String? api}) async {
    var uri = baseUrl + (api ?? "");
    try {
      var response = await dio.delete(
        uri,
      );
      return response;
    } on DioException catch (e) {
      if (e.type == DioException.connectionTimeout) {
        ApiNotRespondingException("Connection Timeout");
      } else if (e.type == DioException.receiveTimeout) {
        ApiNotRespondingException("Connection Timeout");
      } else if (e.type == DioException.connectionError) {
        ApiNotRespondingException("No Internet Connection");
      } else if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
      } else {
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
      }
    }
    return null;
  }

  static Future<bool> isAuthenticated() async {
    // Implement a method to check token validity
    String? localToken = await LocalStore.getToken();
    if (localToken != null && localToken.isNotEmpty) {
      // Optionally, make an API call to verify the token
      try {
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }
}
