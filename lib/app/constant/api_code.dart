import 'dart:core';

enum ApiCode{
  ///API成功返回
  SUCCESS(200),
  ///认证失败
  AUTHENTICATION_FAILED(401);

  final int code;
  const ApiCode(this.code);
}