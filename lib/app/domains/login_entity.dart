import 'dart:convert';

import 'package:rescue_station/app/db/user_info_table.dart';

class LoginEntity {
  String? msg;
  int? code;
  UserInfoTable? data;

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
    data: json["data"] == null ? null : UserInfoTable.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "code": code,
    "data": data?.toJson(),
  };
}