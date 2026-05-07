import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/note/data/post_problem/post_problem_api.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class PostProblemApiRX extends RxResponseInt<Map<String, dynamic>> {
  final api = PostProblemApi.instance;

  PostProblemApiRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postProblemRX({
    required dynamic description,
    required dynamic location,
    required dynamic date,
  }) async {
    try {
      final Map<String, dynamic> data = await api.postProblemApi(
        description: description,
        location: location,
        date: date,
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
        errorMessage = error['error'] ??
            error['message'] ??
            'Problem upload failed failed';
      } else if (error is String) {
        errorMessage = error;
      }

      log('Problem upload failed Error: $error');
      ToastUtil.showShortToast(errorMessage);
      dataFetcher.sink.addError(errorMessage);

      return false;
    } catch (e) {
      log('Error in handleErrorWithReturn: $e');
      return false;
    }
  }
}
