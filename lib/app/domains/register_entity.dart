import 'dart:convert';

class RegisterEntity {
  String? msg;
  int? code;

  RegisterEntity({
    this.msg,
    this.code,
  });

  factory RegisterEntity.fromRawJson(String str) => RegisterEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterEntity.fromJson(Map<String, dynamic> json) => RegisterEntity(
    msg: json["msg"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "code": code,
  };
}
