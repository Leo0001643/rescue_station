// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_box_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageBoxTableAdapter extends TypeAdapter<MessageBoxTable> {
  @override
  final int typeId = 0;

  @override
  MessageBoxTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageBoxTable()
      ..boxId = fields[0] as int?
      ..userId = fields[1] as String?
      ..boxType = fields[2] == null ? 0 : fields[2] as int
      ..lastMessage = fields[3] as dynamic
      ..lastMessageTime = fields[4] as int?
      ..unreadCount = fields[5] as int?
      ..isTop = fields[6] == null ? false : fields[6] as bool
      ..isDisturb = fields[7] == null ? false : fields[7] as bool
      ..isGroup = fields[8] == null ? false : fields[8] as bool
      ..friend = fields[9] as UserInfoTable?
      ..group = fields[10] as dynamic;
  }

  @override
  void write(BinaryWriter writer, MessageBoxTable obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.boxId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.boxType)
      ..writeByte(3)
      ..write(obj.lastMessage)
      ..writeByte(4)
      ..write(obj.lastMessageTime)
      ..writeByte(5)
      ..write(obj.unreadCount)
      ..writeByte(6)
      ..write(obj.isTop)
      ..writeByte(7)
      ..write(obj.isDisturb)
      ..writeByte(8)
      ..write(obj.isGroup)
      ..writeByte(9)
      ..write(obj.friend)
      ..writeByte(10)
      ..write(obj.group);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageBoxTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}