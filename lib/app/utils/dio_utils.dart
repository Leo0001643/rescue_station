import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rescue_station/app/constant/constant.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/shared_preferences_util.dart';

class DioUtil {
  static final DioUtil _instance = DioUtil._internal();
  factory DioUtil() => _instance;
  late Dio dio;

  DioUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: Constant.BASE_URL, // Replace with your base URL
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'version': Constant.VERSION,
        'Authorization': SharedPreferencesUtil.getString("token",defaultValue: ''),
      },
    );
    dio = Dio(options);

    // Add interceptors if needed
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Do something before request is sent
        loggerArray(["发起请求","${options.baseUrl}${options.path}","${options.method}\n","${options.headers}\n",options.data ?? options.queryParameters]);
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        loggerArray(["返回响应",response.requestOptions.path,response.statusCode, "${jsonEncode(response.requestOptions.data)}\n",jsonEncode(response.data)]);
        // Do something with response data
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e); //continue
      },
    ));
  }

  /// Sets a header
  void setHeader(String key, String value) {
    dio.options.headers[key] = value;
  }

  /// Removes a header
  void removeHeader(String key) {
    dio.options.headers.remove(key);
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      Response response = await dio.get(path, queryParameters: queryParameters, options: options);
      return response;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? data, Options? options}) async {
    try {
      Response response = await dio.post(path, data: data, options: options);
      return response;
    } catch (e) {
      throw Exception('Failed to post data');
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? data, Options? options}) async {
    try {
      Response response = await dio.put(path, data: data, options: options);
      return response;
    } catch (e) {
      throw Exception('Failed to update data');
    }
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data, Options? options}) async {
    try {
      Response response = await dio.delete(path, data: data, options: options);
      return response;
    } catch (e) {
      throw Exception('Failed to delete data');
    }
  }
}