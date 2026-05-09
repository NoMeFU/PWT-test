import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<MultipartFile> getMultipartFile(XFile file) async {
  if (kIsWeb) {
    return MultipartFile.fromBytes(
      await file.readAsBytes(),
      filename: file.name,
    );
  } else {
    return await MultipartFile.fromFile(file.path, filename: file.name);
  }
}
