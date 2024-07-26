import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as getx;
import 'package:rescue_station/app/routes/app_pages.dart';

import '../../domains/api_response.dart';
import 'RawData.dart';
import 'api_exception.dart';
import 'network_config.dart';

class RequestClient {
  late Dio _dio;
  static final RequestClient _singletonRequestClient =
  RequestClient._internal();
  factory RequestClient() {
    return _singletonRequestClient;
  }

  RequestClient._internal() {
    var options = BaseOptions(
        baseUrl: NetWorkConfig.baseUrl,
        connectTimeout: NetWorkConfig.connectTimeOut,
        receiveTimeout: NetWorkConfig.readTimeOut,
        sendTimeout: NetWorkConfig.writeTimeOut);
    _dio = Dio(options);
  }


  Future<T?> request<T>(
      String url, {
        required String method,
        Map<String, dynamic>? queryParameters,
        dynamic data,
        Map<String, dynamic>? headers,
        bool Function(ApiException)? onError, //用于错误信息处理的回调
      }) async {
    try {
      Options options = Options()
        ..method = method
        ..headers = headers;
      data = _convertRequestData(data);
      var response = await _dio.request(url,queryParameters: queryParameters, data: data, options: options);
      print("request：$url ,result:$response");
      return _handleResponse<T>(response);
    } catch (e) {
      ///创建 ApiException ，调用 onError，当 onError 返回为 true 时即错误信息已被调用方处理，则不抛出异常，否则抛出异常。
      var exception = ApiException.from(e);
      if (onError?.call(exception) != true) {
        throw exception;
      }
    }
    return null;
  }

  ///将请求 data 数据先使用 jsonEncode 转换为字符串，再使用 jsonDecode 方法将字符串转换为 Map。
  _convertRequestData(data) {
    if (data != null) {
      data = jsonDecode(jsonEncode(data));
    }
    return data;
  }

  ///请求响应内容处理
  T? _handleResponse<T>(Response response) {
    if (response.statusCode == 200) {
      //判断泛型是否为 RawData ，是则直接把 response.data 放入 RawData 中返回，
      //即 RawData 的 value 就是接口返回的原始数据。用于第三方平台的接口请求，返回数据接口不支持定义的ApiResponse的情况
      if (T.toString() == (RawData).toString()) {
        RawData raw = RawData();
        raw.value = response.data;
        return raw as T;
      } else {
        ApiResponse<T> apiResponse = ApiResponse<T>.fromJson(response.data);
        return _handleBusinessResponse<T>(apiResponse);
      }
    } else {
      var exception =
      ApiException(response.statusCode, ApiException.unknownException);
      throw exception;
    }
  }

  ///业务内容处理
  T? _handleBusinessResponse<T>(ApiResponse<T> response) {
    if (response.code == NetWorkConfig.successCode) {
      return response.data;
    } else if(response.code == NetWorkConfig.notCertified){
      getx.Get.toNamed(Routes.TABS);
      var exception = ApiException(response.code, response.msg);
      throw exception;
    }else{
      var exception = ApiException(response.code, response.msg);
      throw exception;
    }
  }

  Future<T?> get<T>(
      String url, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
        bool showLoading = true,
        bool Function(ApiException)? onError,
      }) {
    return request(url,
        method: "Get",
        queryParameters: queryParameters,
        headers: headers,
        onError: onError);
  }

  Future<T?> post<T>(
      String url, {
        Map<String, dynamic>? queryParameters,
        data,
        Map<String, dynamic>? headers,
        bool showLoading = true,
        bool Function(ApiException)? onError,
      }) {
    return request(url,
        method: "POST",
        queryParameters: queryParameters,
        data: data,
        headers: headers,
        onError: onError);
  }

  Future<T?> delete<T>(
      String url, {
        Map<String, dynamic>? queryParameters,
        data,
        Map<String, dynamic>? headers,
        bool showLoading = true,
        bool Function(ApiException)? onError,
      }) {
    return request(url,
        method: "DELETE",
        queryParameters: queryParameters,
        data: data,
        headers: headers,
        onError: onError);
  }

  Future<T?> put<T>(
      String url, {
        Map<String, dynamic>? queryParameters,
        data,
        Map<String, dynamic>? headers,
        bool showLoading = true,
        bool Function(ApiException)? onError,
      }) {
    return request(url,
        method: "PUT",
        queryParameters: queryParameters,
        data: data,
        headers: headers,
        onError: onError);
  }



  //先定义一个顶级的request
/*  Future request(Function() block,  {bool showLoading = true, bool Function(ApiException)? onError, }) async{
    try {
      await loading(block, isShowLoading:  showLoading);
    } catch (e) {
      handleException(ApiException.from(e), onError: onError);
    }
    return;
  }*/

//统一的错误处理
  bool handleException(ApiException exception,
      {bool Function(ApiException)? onError}) {
    if (onError?.call(exception) == true) {
      return true;
    }
//当外部未处理异常时则在 handleException 中进行统一处理
    //todo 错误码统一处理
    // if(exception.code == 401 ){
    //
    //   return true;
    // }
    EasyLoading.showError(exception.message ?? ApiException.unknownException);
    return false;
  }

//请求的dialog
  Future loading( Function block, {bool isShowLoading = true}) async{
    if (isShowLoading) {
      showLoading();
    }
    try {
      await block();
    } catch (e) {
      rethrow;
    } finally {
      dismissLoading();
    }
    return;
  }


  void showLoading(){
    EasyLoading.show(status: "加载中...");
  }

  void dismissLoading(){
    EasyLoading.dismiss();
  }
}