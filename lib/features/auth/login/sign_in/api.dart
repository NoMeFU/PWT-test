import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/endpoints.dart';
import 'package:lawbug829/networks/exception_handler/data_source.dart';

final class SignInApi {
  static final SignInApi _singleton = SignInApi._internal();

  SignInApi._internal();

  static SignInApi get instance => _singleton;

  Future<Map<String, dynamic>> signInApi({
    required String email,
    required dynamic password,
  }) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.logIn(), data));

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
