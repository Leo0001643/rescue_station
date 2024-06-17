import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/entity/user_info_entity.dart';

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
  return userInfoEntity;
}

Map<String, dynamic> $UserInfoEntityToJson(UserInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['portrait'] = entity.portrait;
  data['chatNo'] = entity.chatNo;
  data['nickName'] = entity.nickName;
  data['userType'] = entity.userType;
  return data;
}

extension UserInfoEntityExtension on UserInfoEntity {
  UserInfoEntity copyWith({
    String? userId,
    String? portrait,
    String? chatNo,
    String? nickName,
    String? userType,
  }) {
    return UserInfoEntity()
      ..userId = userId ?? this.userId
      ..portrait = portrait ?? this.portrait
      ..chatNo = chatNo ?? this.chatNo
      ..nickName = nickName ?? this.nickName
      ..userType = userType ?? this.userType;
  }
}