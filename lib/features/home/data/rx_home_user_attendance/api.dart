import 'dart:developer';


import 'package:lawbug829/features/home/model/home_attendance_and_user_info_data.dart';
import 'package:lawbug829/networks/exception_handler/data_source.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';

final class HomeUserAndAttendanceApi {
  static final HomeUserAndAttendanceApi _singleton = HomeUserAndAttendanceApi._internal();
  HomeUserAndAttendanceApi._internal();

  static HomeUserAndAttendanceApi get instance => _singleton;

  Future<HomeUserAndAttendanceDataModel> attendanceAndUserData() async {
    try {
      final response = await getHttp(Endpoints.homeUserAndAttendanceApiLink());
      if (response.statusCode == 200) {
        return HomeUserAndAttendanceDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Error in API: $error");
      rethrow;
    }
  }
}
