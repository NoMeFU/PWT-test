// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';
import 'package:lawbug829/helpers/platform_helper.dart';

urlLunch(String url) {
  if (SafePlatform.isIOS) {
    launch(url, forceSafariVC: false);
  } else {
    launch(url, forceWebView: false);
  }
}
