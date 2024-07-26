import 'dart:convert';

import 'package:dio/dio.dart' as diod;
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/constant/constant.dart';
import 'package:rescue_station/app/domains/upload_file_entity.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import '../routes/app_pages.dart';

class DioUtil {
  static final DioUtil _instance = DioUtil._internal();
  factory DioUtil() => _instance;
  late Dio dio;

  DioUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: Constant.BASE_URL, // Replace with your base URL
      connectTimeout: 60 * 1000,
      receiveTimeout: 30 * 1000,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'version': Constant.VERSION,
      },
    );
    dio = Dio(options);

    // Add interceptors if needed
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        var token = AppData.getUser()?.token.em();
        if(isNotEmpty(token)){
          options.headers['Authorization'] = token;
        }
        // Do something before request is sent
        loggerArray(["发起请求","${options.baseUrl}${options.path}","${options.method}\n","${options.headers}\n",options.data ?? options.queryParameters]);
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        loggerArray(["返回响应",response.requestOptions.path,response.statusCode, jsonEncode(response.data)]);
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

  Future<diod.Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      diod.Response response = await dio.get(path, queryParameters: queryParameters, options: options);
      return response;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future<diod.Response> post(String path, {Map<String, dynamic>? data, Options? options}) async {
    try {
      diod.Response response = await dio.post(path, data: data, options: options);
      return response;
    } catch (e) {
      logger(e);
      throw Exception('Failed to post data');
    }
  }


  Future<diod.Response> postAny(String path, {dynamic data, Options? options}) async {
    try {
      diod.Response response = await dio.post(path, data: data, options: options);
      return response;
    } catch (e) {
      logger(e);
      throw Exception('Failed to post data');
    }
  }

  Future<diod.Response> put(String path, {Map<String, dynamic>? data, Options? options}) async {
    try {
      diod.Response response = await dio.put(path, data: data, options: options);
      return response;
    } catch (e) {
      logger(e);
      throw Exception('Failed to update data');
    }
  }

  Future<diod.Response> delete(String path, {Map<String, dynamic>? data, Options? options}) async {
    try {
      diod.Response response = await dio.delete(path, data: data, options: options);
      return response;
    } catch (e) {
      logger(e);
      throw Exception('Failed to delete data');
    }
  }





  ///上传文件
  static Future<UploadFileEntity?> uploadFile(String filename,String path) async {
    loggerArray(["上传的文件路径",path]);
    var mufile = await diod.MultipartFile.fromFile(path, filename: filename,);
    var result = await DioUtil().postAny(Api.FILE_UPLOAD,data: diod.FormData.fromMap({"file": mufile}),
        options: diod.Options(contentType: "multipart/form-data",headers: {}));
    if(result.data["code"] == 200){
      return UploadFileEntity.fromJson(result.data["data"]);
    } else {
      Get.snackbar('提醒', result.data["msg"]);
      return null;
    }
  }

  ///上传文件
  static Future<UploadFileEntity?> uploadWebFile(String filename,Uint8List bytes) async {
    loggerArray(["上传的文件路径",]);
    var mufile = diod.MultipartFile.fromBytes(bytes, filename: filename,);
    var result = await DioUtil().postAny(Api.FILE_UPLOAD,data: diod.FormData.fromMap({"file": mufile}),
        options: diod.Options(contentType: "multipart/form-data",headers: {}));
    if(result.data["code"] == 200){
      return UploadFileEntity.fromJson(result.data["data"]);
    } else {
      Get.snackbar('提醒', result.data["msg"]);
      return null;
    }
  }

}