import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

// this is the opt verification
final class PostVerifyEmailAPI {
  static final PostVerifyEmailAPI _singleton = PostVerifyEmailAPI._internal();

  PostVerifyEmailAPI._internal();

  static PostVerifyEmailAPI get instance => _singleton;

  // required dynamic password
  Future<Map<String, dynamic>> verifyEmailAPI({
    required dynamic email,
    required dynamic otp,
  }) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "email": email,
        "otp": otp,
      };

      // Make the POST request
      Response response = (await postHttp(Endpoints.verifyEmail(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('OTP Successfully Verified');
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Error during signup: $error");
      rethrow;
    }
  }
}
