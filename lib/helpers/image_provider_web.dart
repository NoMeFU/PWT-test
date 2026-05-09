import 'package:flutter/material.dart';

ImageProvider getPlatformImageProvider(String path) {
  return NetworkImage(path);
}
