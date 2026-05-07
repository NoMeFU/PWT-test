import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/note/model/get_daily_model.dart';
import '/networks/endpoints.dart';
import '../../../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

class GetDailyUpdateAPI {
  static final GetDailyUpdateAPI _singleton = GetDailyUpdateAPI._internal();
  GetDailyUpdateAPI._internal();

  // * Singleton getter
  static GetDailyUpdateAPI get instance => _singleton;

  // * Method to fetch profile data
  Future<GetDailyUpdateModel> getDailyUpdateAPI() async {
    try {
      Response response = await getHttp(
        Endpoints.dailyUpdate(),
      );

      // * Check if the response is successful (HTTP 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));

        // * Decode the response data
        // * Parse the data into a ProfileModel and return it
        return GetDailyUpdateModel.fromJson(data);
      } else {
        // * Handle non-200 status code errors, like 404, 500, etc.
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // * Handle generic errors (like network failures, timeouts, etc.)
      throw ErrorHandler.handle(error).failure;
    }
  }
}
