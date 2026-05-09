import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:lawbug829/helpers/dio_helper.dart';
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
    required XFile avatar,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "avatar": await getMultipartFile(avatar),
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
