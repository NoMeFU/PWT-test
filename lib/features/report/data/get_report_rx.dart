
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lawbug829/features/report/data/get_report_api.dart';
import 'package:lawbug829/features/report/model/working_report_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';
import '../../../helpers/toast.dart';


final class GetReportAPIRX extends RxResponseInt<GetReportModel> {
  final api = GetReportAPI.instance;

  GetReportAPIRX(
      {required super.empty, required super.dataFetcher});

  ValueStream get getAvailableItemsStream => dataFetcher.stream;

  Future<GetReportModel?> reportAPIRX() async {
    try {
      GetReportModel data = await api.getReportApi();
      debugPrint('API Response: ${data.toJson()}');
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }


  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      // Fix: Safely convert message or error to String
      final responseData = error.response?.data;

      if (error.response?.statusCode == 400) {
        ToastUtil.showShortToast(responseData["error"]?.toString() ?? "Something went wrong");
      } else {
        ToastUtil.showShortToast(responseData["message"]?.toString() ?? "Unknown error occurred");
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }


  // @override
  // dynamic handleErrorWithReturn(dynamic error) {
  //   if (error is DioException) {
  //     final dioError = error;
  //     debugPrint('Dio Error: ${dioError.message}');
  //     if (dioError.response != null) {
  //       debugPrint('Status Code: ${dioError.response!.statusCode}');
  //       debugPrint('Response Data: ${dioError.response!.data}');
  //     }
  //     if (error.error is FormatException) {
  //       debugPrint('Date Formatting Error');
  //       return null;
  //     }
  //
  //     return super.handleErrorWithReturn(error);
  //   }
  //   return null;
  // }

}












//
//
// // import '../../../../../networks/rx_base.dart';
// //
// // final class GetReportAPIRX extends RxResponseInt<GetReportModel> {
// //   final api = GetReportAPI.instance;
// //
// //   GetReportAPIRX({required super.empty, required super.dataFetcher});
// //
// //   ValueStream<GetReportModel> get getReportApi => dataFetcher.stream;
// //
// //   Future<void> reportAPIRX() async {
// //     try {
// //       GetReportModel allData = await api.reportAPI();
// //       handleSuccessWithReturn(allData);
// //     } catch (error) {
// //       handleErrorWithReturn(error);
// //     }
// //   }
// //
// //
// //   @override
// //   handleSuccessWithReturn(dynamic data) {
// //     dataFetcher.sink.add(data);
// //     return data;
// //   }
// //
// //   @override
// //
// //   handleErrorWithReturn(error) {
// //     // TODO: implement handleErrorWithReturn
// //     return super.handleErrorWithReturn(error);
// //   }
// //
// //
// //
// // }
//
//
//
//
//
//
//
//
//
//
// import 'package:lawbug829/features/report/data/get_report_api.dart';
// import 'package:lawbug829/features/report/model/working_report_model.dart';
// import 'package:lawbug829/networks/rx_base.dart';
// import 'package:rxdart/rxdart.dart';
//
//
// final class GetReportAPIRX extends RxResponseInt<GetReportModel> {
//   final api = GetReportAPI.instance;
//
//   GetReportAPIRX({required super.empty, required super.dataFetcher});
//
//   ValueStream<GetReportModel> get getReportApi => dataFetcher.stream;
//
//   Future<void> reportAPIRX() async {
//     try {
//       dataFetcher.sink.add(GetReportModel());
//       GetReportModel allData = await api.reportAPI();
//       dataFetcher.sink.add(allData);
//     } catch (error) {
//       dataFetcher.sink.addError(error);
//     }
//   }
//
//   @override
//   void dispose() {
//     dataFetcher.close();
//     super.dispose();
//   }
// }
