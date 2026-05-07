import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class CheckoutAttendenceAPI {
  static final CheckoutAttendenceAPI _singleton = CheckoutAttendenceAPI._internal();

  CheckoutAttendenceAPI._internal();

  static CheckoutAttendenceAPI get instance => _singleton;

  Future<Map<String, dynamic>> CheckoutAttendenceAPIData({
    required dynamic status,
    required dynamic role,
    required dynamic lat,
    required dynamic lang,
    required dynamic time,
  }) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "status": status,
        "role": role,
        "lat": lat,
        "long": lang,
        "time": time,
      };
      Response response =
      (await postHttp(Endpoints.attendancePresentApiLink(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
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
