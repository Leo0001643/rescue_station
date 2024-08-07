
enum MessageTypeEnum{
  TEXT,
  IMAGE,
  FILE,
  VIDEO,
  VOICE,
  LOCATION,
  ALERT,
  SYSTEM,
  NOTIFICATION,
  UNKNOWN,

}

MessageTypeEnum find(String? name){
  var list = MessageTypeEnum.values.where((v)=> v.name == name).toList();
  return list.isEmpty ? MessageTypeEnum.UNKNOWN : list.first;
}

