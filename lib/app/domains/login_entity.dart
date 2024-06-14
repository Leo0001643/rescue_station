import 'dart:convert';

class LoginEntity {
  String? msg;
  int? code;
  Data? data;

  LoginEntity({
    this.msg,
    this.code,
    this.data,
  });

  factory LoginEntity.fromRawJson(String str) => LoginEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginEntity.fromJson(Map<String, dynamic> json) => LoginEntity(
    msg: json["msg"],
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "code": code,
    "data": data?.toJson(),
  };
}

class Data {
  String? token;

  Data({
    this.token,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
