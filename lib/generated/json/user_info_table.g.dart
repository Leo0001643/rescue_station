import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/db/user_info_table.dart';
import 'package:hive_flutter/adapters.dart';


UserInfoTable $UserInfoTableFromJson(Map<String, dynamic> json) {
  final UserInfoTable userInfoTable = UserInfoTable();
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    userInfoTable.userId = userId;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    userInfoTable.portrait = portrait;
  }
  final String? chatNo = jsonConvert.convert<String>(json['chatNo']);
  if (chatNo != null) {
    userInfoTable.chatNo = chatNo;
  }
  final String? nickName = jsonConvert.convert<String>(json['nickName']);
  if (nickName != null) {
    userInfoTable.nickName = nickName;
  }
  final String? userType = jsonConvert.convert<String>(json['userType']);
  if (userType != null) {
    userInfoTable.userType = userType;
  }
  final String? gender = jsonConvert.convert<String>(json['gender']);
  if (gender != null) {
    userInfoTable.gender = gender;
  }
  final String? cover = jsonConvert.convert<String>(json['cover']);
  if (cover != null) {
    userInfoTable.cover = cover;
  }
  final String? provinces = jsonConvert.convert<String>(json['provinces']);
  if (provinces != null) {
    userInfoTable.provinces = provinces;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    userInfoTable.city = city;
  }
  final String? intro = jsonConvert.convert<String>(json['intro']);
  if (intro != null) {
    userInfoTable.intro = intro;
  }
  final String? isFriend = jsonConvert.convert<String>(json['isFriend']);
  if (isFriend != null) {
    userInfoTable.isFriend = isFriend;
  }
  final String? black = jsonConvert.convert<String>(json['black']);
  if (black != null) {
    userInfoTable.black = black;
  }
  final String? source = jsonConvert.convert<String>(json['source']);
  if (source != null) {
    userInfoTable.source = source;
  }
  final String? genderLabel = jsonConvert.convert<String>(json['genderLabel']);
  if (genderLabel != null) {
    userInfoTable.genderLabel = genderLabel;
  }
  final String? sourceLabel = jsonConvert.convert<String>(json['sourceLabel']);
  if (sourceLabel != null) {
    userInfoTable.sourceLabel = sourceLabel;
  }
  return userInfoTable;
}

Map<String, dynamic> $UserInfoTableToJson(UserInfoTable entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['portrait'] = entity.portrait;
  data['chatNo'] = entity.chatNo;
  data['nickName'] = entity.nickName;
  data['userType'] = entity.userType;
  data['gender'] = entity.gender;
  data['cover'] = entity.cover;
  data['provinces'] = entity.provinces;
  data['city'] = entity.city;
  data['intro'] = entity.intro;
  data['isFriend'] = entity.isFriend;
  data['black'] = entity.black;
  data['source'] = entity.source;
  data['genderLabel'] = entity.genderLabel;
  data['sourceLabel'] = entity.sourceLabel;
  return data;
}

extension UserInfoTableExtension on UserInfoTable {
  UserInfoTable copyWith({
    String? userId,
    String? portrait,
    String? chatNo,
    String? nickName,
    String? userType,
    String? gender,
    String? cover,
    String? provinces,
    String? city,
    String? intro,
    String? isFriend,
    String? black,
    String? source,
    String? genderLabel,
    String? sourceLabel,
  }) {
    return UserInfoTable()
      ..userId = userId ?? this.userId
      ..portrait = portrait ?? this.portrait
      ..chatNo = chatNo ?? this.chatNo
      ..nickName = nickName ?? this.nickName
      ..userType = userType ?? this.userType
      ..gender = gender ?? this.gender
      ..cover = cover ?? this.cover
      ..provinces = provinces ?? this.provinces
      ..city = city ?? this.city
      ..intro = intro ?? this.intro
      ..isFriend = isFriend ?? this.isFriend
      ..black = black ?? this.black
      ..source = source ?? this.source
      ..genderLabel = genderLabel ?? this.genderLabel
      ..sourceLabel = sourceLabel ?? this.sourceLabel;
  }
}