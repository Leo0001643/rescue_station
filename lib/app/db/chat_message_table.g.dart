// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageTableAdapter extends TypeAdapter<ChatMessageTable> {
  @override
  final int typeId = 2;

  @override
  ChatMessageTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessageTable()
      ..msgId = fields[0] as String?
      ..pushType = fields[1] as String?
      ..msgContent = (fields[2] as Map?)?.cast<String, dynamic>()
      ..fromInfo = fields[3] as UserInfoTable?
      ..createTime = fields[4] as String?
      ..groupInfo = (fields[5] as Map?)?.cast<String, dynamic>()
      ..userId = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, ChatMessageTable obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.msgId)
      ..writeByte(1)
      ..write(obj.pushType)
      ..writeByte(2)
      ..write(obj.msgContent)
      ..writeByte(3)
      ..write(obj.fromInfo)
      ..writeByte(4)
      ..write(obj.createTime)
      ..writeByte(5)
      ..write(obj.groupInfo)
      ..writeByte(6)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
