import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/profile/data/edit_profile_picture/post_profile_update_api.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class PostImageUploadRx extends RxResponseInt<Map<String, dynamic>> {
  final api = PostImageUploadApi.instance;

  PostImageUploadRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> uploadImageApi({
    required File avatar,
  }) async {
    try {
      Map<String, dynamic> data = await api.uploadImageApi(
        avatar: avatar,
      );
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    log(">>>>>>>>>>>>>>>>>>>>> Image upload success");
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final errorMessage =
          error.response?.data["message"] ?? "Something went wrong";
      ToastUtil.showShortToast(errorMessage);
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
