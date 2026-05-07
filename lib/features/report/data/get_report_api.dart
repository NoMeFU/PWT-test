
import 'package:dio/dio.dart';
import 'package:lawbug829/features/report/model/working_report_model.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/endpoints.dart';
import 'package:lawbug829/networks/exception_handler/data_source.dart';

final class GetReportAPI {
  static final GetReportAPI _singleton =
  GetReportAPI._internal();
  GetReportAPI._internal();

  static GetReportAPI get instance => _singleton;

  Future<GetReportModel> getReportApi() async {
    try {
      Response response = await getHttp(Endpoints.getReport());
      if (response.statusCode == 200) {
        final data = GetReportModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}












// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:lawbug829/features/report/model/working_report_model.dart';
// import '/networks/endpoints.dart';
// import '../../../../../../../networks/dio/dio.dart';
// import '../../../../../networks/exception_handler/data_source.dart';
// // Import DataSource for failure handling
//
// class GetReportAPI {
//   static final GetReportAPI _singleton = GetReportAPI._internal();
//   GetReportAPI._internal();
//
//   // Singleton getter
//   static GetReportAPI get instance => _singleton;
//
//   // * Method to fetch profile data
//   Future<GetReportModel> reportAPI() async {
//     try {
//       Response response = await getHttp(
//         Endpoints.getReport(),
//       );
//
//       // * Check if the response is successful (HTTP 200)
//       if (response.statusCode == 200) {
//         Map<String, dynamic> data = json.decode(json.encode(response.data));
//         return GetReportModel.fromJson(data);
//       } else {
//         throw DataSource.DEFAULT.getFailure();
//       }
//     } catch (error) {
//       // * Handle generic errors (like network failures, timeouts, etc.)
//       throw ErrorHandler.handle(error).failure;
//     }
//   }
// }
