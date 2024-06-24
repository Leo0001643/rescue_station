class ApiResponse<T> {
  String? msg;
  int? code;
  dynamic? data;

  ApiResponse({this.msg, this.code, this.data});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final resposne = <String, dynamic>{};
    resposne['msg'] = msg;
    resposne['code'] = code;
    resposne['data'] =  data;
    return resposne;
  }
}
