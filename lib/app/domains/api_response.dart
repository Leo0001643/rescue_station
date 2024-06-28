import 'package:rescue_station/generated/json/base/json_convert_content.dart';

class ApiResponse<T> {
  String? msg;
  int? code;
  T? data;

  ApiResponse();

  ApiResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = JsonConvert.fromJsonAsT<T>(json['data']);
  }

  Map<String, dynamic> toJson() {
    final resposne = <String, dynamic>{};
    resposne['msg'] = msg;
    resposne['code'] = code;
    resposne['data'] =  data;
    return resposne;
  }
}
