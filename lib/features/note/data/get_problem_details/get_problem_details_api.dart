import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/note/model/get_problem_details.dart';
import '/networks/endpoints.dart';
import '../../../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
// Import DataSource for failure handling

class GetProblemDetailsApi {
  static final GetProblemDetailsApi _singleton =
      GetProblemDetailsApi._internal();
  GetProblemDetailsApi._internal();

  // Singleton getter
  static GetProblemDetailsApi get instance => _singleton;

  // * Method to fetch profile data
  Future<GetProblemDetailsModel> getProblemDetailsApi({
    required dynamic id,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.getFacingProblemDetails(id),
      );

      // * Check if the response is successful (HTTP 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));

        // * Decode the response data
        // * Parse the data into a ProfileModel and return it
        return GetProblemDetailsModel.fromJson(data);
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
