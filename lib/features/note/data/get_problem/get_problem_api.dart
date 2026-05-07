import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/note/model/get_problem_model.dart';
import '/networks/endpoints.dart';
import '../../../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
// Import DataSource for failure handling

class GetProblemApi {
  static final GetProblemApi _singleton = GetProblemApi._internal();
  GetProblemApi._internal();

  // Singleton getter
  static GetProblemApi get instance => _singleton;

  // * Method to fetch profile data
  Future<GetProblemModel> getProblemAPI() async {
    try {
      Response response = await getHttp(
        Endpoints.getFacingProblem(),
      );

      // * Check if the response is successful (HTTP 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));

        // * Decode the response data
        // * Parse the data into a ProfileModel and return it
        return GetProblemModel.fromJson(data);
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
