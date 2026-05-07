import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/report/model/expense_model.dart';
import '/networks/endpoints.dart';
import '../../../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';
// Import DataSource for failure handling

class GetExpenseAPI {
  static final GetExpenseAPI _singleton = GetExpenseAPI._internal();
  GetExpenseAPI._internal();

  // Singleton getter
  static GetExpenseAPI get instance => _singleton;

  // * Method to fetch profile data
  Future<ExpenseModel> expenseAPI() async {
    try {
      Response response = await getHttp(
        Endpoints.getExpense(),
      );

      // * Check if the response is successful (HTTP 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));
        // * Decode the response data
        // * Parse the data into a GetExpenseModel and return it
        return ExpenseModel.fromJson(data);
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
