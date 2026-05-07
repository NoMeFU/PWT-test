import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/constants/app_constants.dart';
import 'package:lawbug829/features/subscription/subcription_service/subscription_config.dart';
import 'package:lawbug829/helpers/di.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

import 'api.dart';

final class SignInApiRx extends RxResponseInt<Map<String, dynamic>> {
  final api = SignInApi.instance;

  SignInApiRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> signIn({
    required String email,
    required dynamic password,
  }) async {
    try {
      final Map<String, dynamic> data =
          await api.signInApi(email: email, password: password);

      if (data['success'] == true) {
        log('[SignInApiRx] ✅ signIn() — login successful');
        await handleSuccessWithReturn(data);
        return true;
      } else {
        await handleErrorWithReturn(data['error'] ?? 'Sign in failed');
        return false;
      }
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<void> handleSuccessWithReturn(Map<String, dynamic> data) async {
    try {
      final responseData = data['data'];
      if (responseData != null && responseData['token'] != null) {
        final String token = responseData['token'];
        final String userID = responseData['user']['id'].toString();
        log("Login token: $token");
        log("User ID: $userID");

        // Store token and login status
        await appData.write(kKeyAccessToken, token);
        await appData.write(kKeyIsLoggedIn, true);
        await appData.write(kKeyUserID, userID);

        // Update Dio instance with new token
        DioSingleton.instance.update(token);

        PurchaseHelper.init(id: userID);

        // Add success data to stream
        dataFetcher.sink.add(data);
      } else {
        throw Exception('Invalid response data structure');
      }
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
        errorMessage = error['error'] ?? error['message'] ?? 'Sign in failed';
      } else if (error is String) {
        errorMessage = error;
      }

      log('SignIn Error: $error');
      ToastUtil.showShortToast(errorMessage);
      dataFetcher.sink.addError(errorMessage);

      return false;
    } catch (e) {
      log('Error in handleErrorWithReturn: $e');
      return false;
    }
  }
}
