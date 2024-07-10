import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/domains/upload_file_entity.dart';

UploadFileEntity $UploadFileEntityFromJson(Map<String, dynamic> json) {
  final UploadFileEntity uploadFileEntity = UploadFileEntity();
  final String? fileName = jsonConvert.convert<String>(json['fileName']);
  if (fileName != null) {
    uploadFileEntity.fileName = fileName;
  }
  final String? fullPath = jsonConvert.convert<String>(json['fullPath']);
  if (fullPath != null) {
    uploadFileEntity.fullPath = fullPath;
  }
  final String? fileType = jsonConvert.convert<String>(json['fileType']);
  if (fileType != null) {
    uploadFileEntity.fileType = fileType;
  }
  return uploadFileEntity;
}

Map<String, dynamic> $UploadFileEntityToJson(UploadFileEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['fileName'] = entity.fileName;
  data['fullPath'] = entity.fullPath;
  data['fileType'] = entity.fileType;
  return data;
}

extension UploadFileEntityExtension on UploadFileEntity {
  UploadFileEntity copyWith({
    String? fileName,
    String? fullPath,
    String? fileType,
  }) {
    return UploadFileEntity()
      ..fileName = fileName ?? this.fileName
      ..fullPath = fullPath ?? this.fullPath
      ..fileType = fileType ?? this.fileType;
  }
}