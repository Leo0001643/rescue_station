// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoTableAdapter extends TypeAdapter<UserInfoTable> {
  @override
  final int typeId = 1;

  @override
  UserInfoTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfoTable(
      userId: fields[0] as String?,
    )
      ..portrait = fields[1] as String?
      ..chatNo = fields[2] as String?
      ..nickName = fields[3] as String?
      ..userType = fields[4] as String?
      ..gender = fields[5] as String?
      ..cover = fields[6] as String?
      ..provinces = fields[7] as String?
      ..city = fields[8] as String?
      ..intro = fields[9] as String?
      ..isFriend = fields[10] as String?
      ..black = fields[11] as String?
      ..source = fields[12] as String?
      ..genderLabel = fields[13] as String?
      ..sourceLabel = fields[14] as String?;
  }

  @override
  void write(BinaryWriter writer, UserInfoTable obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.portrait)
      ..writeByte(2)
      ..write(obj.chatNo)
      ..writeByte(3)
      ..write(obj.nickName)
      ..writeByte(4)
      ..write(obj.userType)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.cover)
      ..writeByte(7)
      ..write(obj.provinces)
      ..writeByte(8)
      ..write(obj.city)
      ..writeByte(9)
      ..write(obj.intro)
      ..writeByte(10)
      ..write(obj.isFriend)
      ..writeByte(11)
      ..write(obj.black)
      ..writeByte(12)
      ..write(obj.source)
      ..writeByte(13)
      ..write(obj.genderLabel)
      ..writeByte(14)
      ..write(obj.sourceLabel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
