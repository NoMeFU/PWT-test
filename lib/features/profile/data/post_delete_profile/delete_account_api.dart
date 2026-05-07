import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class DeleteAccountApi {
  static final DeleteAccountApi _singleton = DeleteAccountApi._internal();
  DeleteAccountApi._internal();

  static DeleteAccountApi get instance => _singleton;

  Future<Map> deleteAccount() async {
    try {
      Response response = await postHttp(Endpoints.deleteAccount());

      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow; // Rethrow the error to be caught in the calling method
    }
  }
}
