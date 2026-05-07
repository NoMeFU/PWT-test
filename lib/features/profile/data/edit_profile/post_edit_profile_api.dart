// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/endpoints.dart';
import 'package:lawbug829/networks/exception_handler/data_source.dart';

final class PostEditProfileAPI {
  static final PostEditProfileAPI _singleton = PostEditProfileAPI._internal();

  PostEditProfileAPI._internal();

  static PostEditProfileAPI get instance => _singleton;

  Future<Map<String, dynamic>> postEditProfileAPI({
    dynamic email,
    dynamic name,
    dynamic phone,
    dynamic address,
    dynamic country_code,
    dynamic employee_id,
    dynamic gender,
    dynamic dob,
  }) async {
    try {
      // * Create the request data map
      Map<String, dynamic> data = {
        'email': email,
        'name': name,
        'phone': phone,
        'address': address,
        'country_code': country_code,
        'employee_id': employee_id,
        'gender': gender,
        'dob': dob,
      };

      // * Make the POST request
      Response response = (await postHttp(Endpoints.postEditProfile(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Update Successfully');
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Error during update profile: $error");
      rethrow;
    }
  }
}
