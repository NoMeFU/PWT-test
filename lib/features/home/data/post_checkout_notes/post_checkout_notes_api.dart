import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/endpoints.dart';
import 'package:lawbug829/networks/exception_handler/data_source.dart';

final class PostCheckoutNoteAPI {
  static final PostCheckoutNoteAPI _singleton = PostCheckoutNoteAPI._internal();

  PostCheckoutNoteAPI._internal();

  static PostCheckoutNoteAPI get instance => _singleton;

  Future<Map<String, dynamic>> postCheckoutNoteAPI({
    required dynamic task_date,
    required dynamic employee_checking_id,
    required List tasks,
  }) async {
    try {
      // * Create the request data map
      Map<String, dynamic> data = {
        "task_date": task_date,
        "tasks": tasks,
        "employee_checking_id": employee_checking_id,
      };

      // * Make the POST request
      Response response = (await postHttp(Endpoints.postCheckoutNote(), data));

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
