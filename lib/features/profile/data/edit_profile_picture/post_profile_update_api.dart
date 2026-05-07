import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';

final class PostImageUploadApi {
  static final PostImageUploadApi _singleton = PostImageUploadApi._internal();
  PostImageUploadApi._internal();
  static PostImageUploadApi get instance => _singleton;

  Future<Map<String, dynamic>> uploadImageApi({
    required File avatar,
  }) async {
    try {
      if (!await avatar.exists()) {
        throw Exception("File does not exist at path: ${avatar.path}");
      }

      FormData data = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(avatar.path),
      });

      Response response = await postHttp(Endpoints.postImageUploadApi(), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast("Profile Picture updated successfully");
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
