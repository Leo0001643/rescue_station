import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as diod;
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
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
      connectTimeout: 120 * 1000,
      receiveTimeout: 120 * 1000,
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
    } else if(result.data["code"] == 401){
      WidgetUtils.logSqueezeOut();
      return null;
    } else {
      Get.snackbar('提醒', result.data["msg"]);
      return null;
    }
  }

  ///上传文件
  static Future<UploadFileEntity?> uploadWebFile(String filename,Uint8List bytes) async {
    loggerArray(["上传的文件路径",filename]);
    var mufile = diod.MultipartFile.fromBytes(bytes, filename: filename,);
    var result = await DioUtil().postAny(Api.FILE_UPLOAD,data: diod.FormData.fromMap({"file": mufile}),
        options: diod.Options(contentType: "multipart/form-data",headers: {}));
    if(result.data["code"] == 200){
      return UploadFileEntity.fromJson(result.data["data"]);
    } else if(result.data["code"] == 401){
      WidgetUtils.logSqueezeOut();
      return null;
    } else {
      Get.snackbar('提醒', result.data["msg"]);
      return null;
    }
  }


  /// 开始下载
  static void download(String filename,String uri) async {
    // var destinationFilename = "${ConfigManager.getBucket()}_${DateUtil.formatDate(DateTime.now(),format: "yyyyMMddHHmmss")}.apk";
    try {
      var dir = await getDownloadsDirectory();
      var fillName = "${dir?.path}/$filename";
      loggerArray(["文件下载地址打印",uri,fillName]);

      Dio().download(uri.em(), fillName).then((value) {
        // EasyLoading.dismiss();
        var response = value.data as ResponseBody;
        if(response.statusCode != null && response.statusCode! >= 200 && response.statusCode! <= 299){
          loggerArray(["文件是否存在",fillName,File(fillName).existsSync()]);
          if(File(fillName).existsSync()){
            OpenFile.open(fillName);
          }
        } else {
          // ErrorResponseHandler().onErrorHandle({"code": response.statusCode,"message": response.statusMessage.toString()});
        }
      },onError: (e){});
    } catch (e) {
      // ErrorResponseHandler().onErrorHandle(e);
    }
  }

}