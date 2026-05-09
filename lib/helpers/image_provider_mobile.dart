import 'dart:io';
import 'package:flutter/material.dart';

ImageProvider getPlatformImageProvider(String path) {
  return FileImage(File(path));
}
