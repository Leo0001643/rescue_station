import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/modules/contacts_module/azlistview/az_common.dart';


UserInfoEntity $UserInfoEntityFromJson(Map<String, dynamic> json) {
  final UserInfoEntity userInfoEntity = UserInfoEntity();
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    userInfoEntity.userId = userId;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    userInfoEntity.portrait = portrait;
  }
  final String? chatNo = jsonConvert.convert<String>(json['chatNo']);
  if (chatNo != null) {
    userInfoEntity.chatNo = chatNo;
  }
  final String? nickName = jsonConvert.convert<String>(json['nickName']);
  if (nickName != null) {
    userInfoEntity.nickName = nickName;
  }
  final String? userType = jsonConvert.convert<String>(json['userType']);
  if (userType != null) {
    userInfoEntity.userType = userType;
  }
  final String? gender = jsonConvert.convert<String>(json['gender']);
  if (gender != null) {
    userInfoEntity.gender = gender;
  }
  final String? cover = jsonConvert.convert<String>(json['cover']);
  if (cover != null) {
    userInfoEntity.cover = cover;
  }
  final String? provinces = jsonConvert.convert<String>(json['provinces']);
  if (provinces != null) {
    userInfoEntity.provinces = provinces;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    userInfoEntity.city = city;
  }
  final String? intro = jsonConvert.convert<String>(json['intro']);
  if (intro != null) {
    userInfoEntity.intro = intro;
  }
  final String? isFriend = jsonConvert.convert<String>(json['isFriend']);
  if (isFriend != null) {
    userInfoEntity.isFriend = isFriend;
  }
  final String? black = jsonConvert.convert<String>(json['black']);
  if (black != null) {
    userInfoEntity.black = black;
  }
  final String? source = jsonConvert.convert<String>(json['source']);
  if (source != null) {
    userInfoEntity.source = source;
  }
  final String? genderLabel = jsonConvert.convert<String>(json['genderLabel']);
  if (genderLabel != null) {
    userInfoEntity.genderLabel = genderLabel;
  }
  final String? sourceLabel = jsonConvert.convert<String>(json['sourceLabel']);
  if (sourceLabel != null) {
    userInfoEntity.sourceLabel = sourceLabel;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userInfoEntity.phone = phone;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    userInfoEntity.token = token;
  }
  final bool? select = jsonConvert.convert<bool>(json['select']);
  if (select != null) {
    userInfoEntity.select = select;
  }
  final String? tabIndex = jsonConvert.convert<String>(json['tabIndex']);
  if (tabIndex != null) {
    userInfoEntity.tabIndex = tabIndex;
  }
  return userInfoEntity;
}

Map<String, dynamic> $UserInfoEntityToJson(UserInfoEntity entity) {
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
  data['phone'] = entity.phone;
  data['token'] = entity.token;
  data['select'] = entity.select;
  data['tabIndex'] = entity.tabIndex;
  return data;
}

extension UserInfoEntityExtension on UserInfoEntity {
  UserInfoEntity copyWith({
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
    String? phone,
    String? token,
    bool? select,
    String? tabIndex,
  }) {
    return UserInfoEntity()
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
      ..sourceLabel = sourceLabel ?? this.sourceLabel
      ..phone = phone ?? this.phone
      ..token = token ?? this.token
      ..select = select ?? this.select
      ..tabIndex = tabIndex ?? this.tabIndex;
  }
}