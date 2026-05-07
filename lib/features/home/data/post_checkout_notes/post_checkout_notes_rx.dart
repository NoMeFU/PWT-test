import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/home/data/post_checkout_notes/post_checkout_notes_api.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class PostCheckoutNoteApiRX extends RxResponseInt<Map<String, dynamic>> {
  final api = PostCheckoutNoteAPI.instance;

  PostCheckoutNoteApiRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postCheckoutNoteRX({
    required dynamic task_date,
    required dynamic employee_checking_id,
    required List tasks,
  }) async {
    try {
      final Map<String, dynamic> data = await api.postCheckoutNoteAPI(
        task_date: task_date,
        tasks: tasks,
        employee_checking_id: employee_checking_id,
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
          if (responseData is Map && responseData.containsKey('error')) {
            final errorData = responseData['error'];
            if (errorData is Map) {
              // Extract validation errors (e.g., tasks.0.task_name)
              errorMessage = errorData.values
                  .expand((errors) => errors as List)
                  .join(', ');
            } else {
              errorMessage = responseData['message'] ??
                  error.response?.statusMessage ??
                  'Server error';
            }
          } else {
            errorMessage = error.response?.statusMessage ?? 'Server error';
          }
        } else {
          errorMessage = error.message ?? 'Network error';
        }
      } else if (error is Map) {
        if (error.containsKey('error') && error['error'] is Map) {
          // Handle validation errors from the API
          final errorData = error['error'] as Map;
          errorMessage =
              errorData.values.expand((errors) => errors as List).join(', ');
        } else {
          errorMessage = error['message'] ?? 'Operation failed';
        }
      } else if (error is String) {
        errorMessage = error;
      }

      log('Error: $errorMessage');
      ToastUtil.showShortToast(errorMessage);
      dataFetcher.sink.addError(errorMessage);

      return false;
    } catch (e) {
      log('Error in handleErrorWithReturn: $e');
      ToastUtil.showShortToast('An unexpected error occurred');
      dataFetcher.sink.addError('An unexpected error occurred');
      return false;
    }
  }
}
