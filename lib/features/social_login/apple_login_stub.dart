import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lawbug829/helpers/toast.dart';

class SocialAuthApple {
  static Future<UserCredential?> signInWithApple(BuildContext context) async {
    ToastUtil.showLongToast("Apple Sign-In is not supported on Web in this configuration.");
    return null;
  }
}
