import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

// this is the opt verification
final class VerifyForgetOtpApi {
  static final VerifyForgetOtpApi _singleton = VerifyForgetOtpApi._internal();

  VerifyForgetOtpApi._internal();

  static VerifyForgetOtpApi get instance => _singleton;

  // required dynamic password
  Future<Map<String, dynamic>> forgetOTPApi({
    required String email,
    required String otp,
  }) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "email": email,
        "otp": otp,
      };

      // Make the POST request
      Response response = (await postHttp(Endpoints.verifyForgetOtp(), data));

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
