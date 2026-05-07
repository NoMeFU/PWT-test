// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/auth/forget_password/data/verify_email/verify_email_api.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

// this is the otp rx
final class PostVerifyEmailApiRX extends RxResponseInt<Map<String, dynamic>> {
  final api = PostVerifyEmailAPI.instance;

  PostVerifyEmailApiRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> verifyEmailRX({
    required dynamic email,
    required dynamic otp,
    //required dynamic password,
  }) async {
    try {
      // Call the otp API
      Map<String, dynamic> data = await api.verifyEmailAPI(
        email: email,
        otp: otp,
      ); //, password: password
      await handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  // @override
  // Future<bool> handleSuccessWithReturn(data) async {
  //   try {
  //     if (data.containsKey('status') && data['status'] == true) {
  //       ToastUtil.showShortToast("OTP matched successfully");
  //       return true;
  //     } else {
  //       String errorMsg = data['message'] ?? "Something went wrong!";
  //       ToastUtil.showShortToast(errorMsg);
  //       return false;
  //     }
  //   } catch (e) {
  //     ToastUtil.showShortToast('Failed to save login data. Please try again.');
  //     return false;
  //   }
  // }

  @override
  bool handleErrorWithReturn(error) {
    try {
      DioException exception = error as DioException;

      final responseData = exception.response?.data;
      String msg = responseData['message'];
      ToastUtil.showShortToast(msg);
    } catch (e) {
      ToastUtil.showShortToast('Something went wrong ✖');
    }
    log(error.runtimeType.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
