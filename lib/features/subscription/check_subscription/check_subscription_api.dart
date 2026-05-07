import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/subscription/model/subscription_check_model.dart';
import '/networks/endpoints.dart';
import '../../../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';
// Import DataSource for failure handling

class GetSubscriptionCheckAPI {
  static final GetSubscriptionCheckAPI _singleton =
      GetSubscriptionCheckAPI._internal();
  GetSubscriptionCheckAPI._internal();

  // Singleton getter
  static GetSubscriptionCheckAPI get instance => _singleton;

  // * Method to fetch profile data
  Future<CheckSubscription> getSubscriptionCheckAPI() async {
    try {
      Response response = await getHttp(
        Endpoints.checkSubscription(),
      );

      // * Check if the response is successful (HTTP 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));
        // * Decode the response data
        // * Parse the data into a CheckSubscription and return it
        return CheckSubscription.fromJson(data);
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
