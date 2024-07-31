import 'package:rescue_station/generated/json/base/json_field.dart';
import 'package:rescue_station/generated/json/upload_file_entity.g.dart';
import 'dart:convert';
export 'package:rescue_station/generated/json/upload_file_entity.g.dart';

@JsonSerializable()
class UploadFileEntity {
	String? fileName;
	String? fullPath;
	String? fileType;
	String? fileSize;

	UploadFileEntity({this.fullPath,this.fileName,this.fileType,this.fileSize});

	factory UploadFileEntity.fromJson(Map<String, dynamic> json) => $UploadFileEntityFromJson(json);

	Map<String, dynamic> toJson() => $UploadFileEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}