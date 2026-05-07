import 'dart:convert';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';

final class PostForgetApi {
  static final PostForgetApi _singleton = PostForgetApi._internal();
  PostForgetApi._internal();
  static PostForgetApi get instance => _singleton;

  Future<dynamic> forget({
    required String email,
  }) async {
    try {
      Map data = {
        "email": email,
      };
      Response response = await postHttp(Endpoints.forgetPass(), data);
      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        Map data = json.decode(json.encode(response.data));
        return data;
        // throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // SignUpResponse _signUpRes = SignUpResponse.fromJson(error);
      rethrow;
    }
  }
}
