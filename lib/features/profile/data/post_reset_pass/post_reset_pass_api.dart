import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/endpoints.dart';
import 'package:lawbug829/networks/exception_handler/data_source.dart';

final class PostResetPassApi {
  static final PostResetPassApi _singleton = PostResetPassApi._internal();

  PostResetPassApi._internal();

  static PostResetPassApi get instance => _singleton;

  Future<Map<String, dynamic>> postResetPass({
    required dynamic old_password,
    required dynamic new_password,
    required dynamic new_password_confirmation,
  }) async {
    try {
      // * Create the request data map
      Map<String, dynamic> data = {
        "old_password": old_password,
        "new_password": new_password,
        "new_password_confirmation": new_password_confirmation,
      };

      // * Make the POST request
      Response response = (await postHttp(Endpoints.postResetPass(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Login Successfully');
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during signup: $error");
      rethrow;
    }
  }
}
