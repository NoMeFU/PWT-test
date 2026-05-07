import 'dart:io';
import 'package:flutter/foundation.dart';

class SafePlatform {
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isWeb => kIsWeb;
}
