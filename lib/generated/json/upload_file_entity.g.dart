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
  final String? fileSize = jsonConvert.convert<String>(json['fileSize']);
  if (fileSize != null) {
    uploadFileEntity.fileSize = fileSize;
  }
  return uploadFileEntity;
}

Map<String, dynamic> $UploadFileEntityToJson(UploadFileEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['fileName'] = entity.fileName;
  data['fullPath'] = entity.fullPath;
  data['fileType'] = entity.fileType;
  data['fileSize'] = entity.fileSize;
  return data;
}

extension UploadFileEntityExtension on UploadFileEntity {
  UploadFileEntity copyWith({
    String? fileName,
    String? fullPath,
    String? fileType,
    String? fileSize,
  }) {
    return UploadFileEntity()
      ..fileName = fileName ?? this.fileName
      ..fullPath = fullPath ?? this.fullPath
      ..fileType = fileType ?? this.fileType
      ..fileSize = fileSize ?? this.fileSize;
  }
}