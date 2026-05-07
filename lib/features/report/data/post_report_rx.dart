import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/report/data/post_report_api.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class PostExpenseApiRX extends RxResponseInt<Map<String, dynamic>> {
  final api = PostExpenseApi.instance;

  PostExpenseApiRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postExpenseRX({
    required dynamic amount_spent,
    required dynamic date,
    required dynamic category,
    required dynamic payment_method,
    required dynamic location,
    required dynamic description,
    required dynamic file,
  }) async {
    try {
      final Map<String, dynamic> data = await api.postExpenseApi(
        amount_spent: amount_spent,
        date: date,
        category: category,
        payment_method: payment_method,
        location: location,
        description: description,
        file: file,
      );

      if (data['success'] == true) {
        await handleSuccessWithReturn(data);
        return true;
      } else {
        await handleErrorWithReturn(
            data['error'] ?? 'Facing problem created failed');
        return false;
      }
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<void> handleSuccessWithReturn(Map<String, dynamic> data) async {
    try {
      final message = data['message'] ?? 'Facing problem created successfully';
      log("Facing problem created successfully: $message");

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
