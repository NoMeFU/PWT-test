import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/endpoints.dart';
import 'package:lawbug829/networks/exception_handler/data_source.dart';

final class PostProblemApi {
  static final PostProblemApi _singleton = PostProblemApi._internal();

  PostProblemApi._internal();

  static PostProblemApi get instance => _singleton;

  Future<Map<String, dynamic>> postProblemApi({
    required dynamic description,
    required dynamic location,
    required dynamic date,
  }) async {
    try {
      // * Create the request data map
      Map<String, dynamic> data = {
        "description": description,
        "location": location,
        "date": date,
      };

      // * Make the POST request
      Response response = (await postHttp(Endpoints.postFacingProblem(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Complain Send Successfully');
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during sending: $error");
      rethrow;
    }
  }
}
