import 'dart:developer';
import 'package:lawbug829/features/home/model/check_in_check_out_data_model.dart';
import 'package:lawbug829/networks/exception_handler/data_source.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';

final class CheckInCheckOutApi {
  static final CheckInCheckOutApi _singleton = CheckInCheckOutApi._internal();
  CheckInCheckOutApi._internal();

  static CheckInCheckOutApi get instance => _singleton;

  Future<CheckInCheckOutDataModel> checkInCheckOutData() async {
    try {
      final response = await getHttp(Endpoints.checkInCheckOutApiLink());
      if (response.statusCode == 200) {
        return CheckInCheckOutDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Error in API: $error");
      rethrow;
    }
  }
}
