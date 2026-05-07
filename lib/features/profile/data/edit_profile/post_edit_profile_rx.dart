// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/profile/data/edit_profile/post_edit_profile_api.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class PostEditProfileApiRX extends RxResponseInt<Map<String, dynamic>> {
  final api = PostEditProfileAPI.instance;

  PostEditProfileApiRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postEditProfileRX({
    dynamic email,
    dynamic name,
    dynamic phone,
    dynamic address,
    dynamic country_code,
    dynamic employee_id,
    dynamic gender,
    dynamic dob,
  }) async {
    try {
      final Map<String, dynamic> data = await api.postEditProfileAPI(
        email: email,
        name: name,
        phone: phone,
        address: address,
        country_code: country_code,
        employee_id: employee_id,
        gender: gender,
        dob: dob,
      );

      if (data['success'] == true) {
        await handleSuccessWithReturn(data);
        return true;
      } else {
        await handleErrorWithReturn(data['error'] ?? 'Password reset failed');
        return false;
      }
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<void> handleSuccessWithReturn(Map<String, dynamic> data) async {
    try {
      final message = data['message'] ?? 'Password updated successfully.';
      log("Password reset success: $message");

      // You can show a toast here if needed
      ToastUtil.showShortToast(message);

      // No token, no login status changes, just add response to stream
      dataFetcher.sink.add(data);
    } catch (e) {
      log('Error in handleSuccessWithReturn: $e');
      dataFetcher.sink.addError(e);
      rethrow;
    }
  }

  @override
  Future<bool> handleErrorWithReturn(dynamic error) async {
    try {
      String errorMessage = 'An error occurred';

      if (error is DioException) {
        if (error.response != null) {
          final responseData = error.response?.data;
          errorMessage = responseData?['error'] ??
              responseData?['message'] ??
              error.response?.statusMessage ??
              'Server error';
        } else {
          errorMessage = error.message ?? 'Network error';
        }
      } else if (error is Map) {
        errorMessage =
            error['error'] ?? error['message'] ?? 'Password reset failed';
      } else if (error is String) {
        errorMessage = error;
      }

      log('Password Reset Error: $error');
      ToastUtil.showShortToast(errorMessage);
      dataFetcher.sink.addError(errorMessage);

      return false;
    } catch (e) {
      log('Error in handleErrorWithReturn: $e');
      return false;
    }
  }
}
