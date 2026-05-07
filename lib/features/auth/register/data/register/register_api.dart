import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';

final class SignupApi {
  static final SignupApi _singleton = SignupApi._internal();
  SignupApi._internal();
  static SignupApi get instance => _singleton;

  Future<dynamic> signupApi({
    required dynamic employee_id,
    required dynamic name,
    required dynamic email,
    required dynamic password,
    required dynamic password_confirmation,
    required dynamic current_location,
    required dynamic lat,
    required dynamic long,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password_confirmation,
        "employee_id": employee_id,
        "current_location": current_location,
        "lat": lat,
        "long": long,
      });

      Response response = await postHttp(Endpoints.register(), data);
      /// Check the response status and return the data accordingly
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast("Sign Up Successfully");
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle errors
      rethrow;
    }
  }
}
