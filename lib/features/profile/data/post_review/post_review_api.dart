import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/endpoints.dart';
import 'package:lawbug829/networks/exception_handler/data_source.dart';

final class PostRatingApi {
  static final PostRatingApi _singleton = PostRatingApi._internal();

  PostRatingApi._internal();

  static PostRatingApi get instance => _singleton;

  Future<Map<String, dynamic>> postRatingAPI({
    required dynamic rating,
    required dynamic review,
  }) async {
    try {
      // * Create the request data map
      Map<String, dynamic> data = {
        "rating": rating,
        "review": review,
      };

      // * Make the POST request
      Response response = (await postHttp(Endpoints.postRating(), data));

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
