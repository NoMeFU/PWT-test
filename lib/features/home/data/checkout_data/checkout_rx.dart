import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/home/data/checkout_data/checkout_api.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:rxdart/streams.dart';
import '../../../../networks/rx_base.dart';

final class CheckoutAttendenceRX extends RxResponseInt<Map<String, dynamic>> {
  final api = CheckoutAttendenceAPI.instance;
  dynamic id;

  CheckoutAttendenceRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> checkoutAttendanceInfo({
    required dynamic status,
    required dynamic role,
    required dynamic lat,
    required dynamic lang,
    required dynamic time,
  }) async {
    try {
      final data = await api.CheckoutAttendenceAPIData(
        status: status,
        lang: lang,
        lat: lat,
        role: role,
        time: time,
      );
      await handleSuccessWithReturn(data);
      log('[CheckoutAttendenceRX] ✅ checkoutAttendanceInfo() — checkout successful');
      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    if (data["data"] != null && 
        data["data"]["attendance"] != null && 
        data["data"]["attendance"]['id'] != null) {
      id = data["data"]["attendance"]['id'];
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.. id is ${id.toString()}");
    } else {
      log("Warning: Attendance ID not found in response data");
    }
    return;
  }

  @override
  handleErrorWithReturn(error) {
    log('[CheckoutAttendenceRX] ❌ handleErrorWithReturn — error type: ${error.runtimeType}');
    String errorMessage = "An unexpected error occurred";

    if (error is DioException) {
      errorMessage = error.message ?? error.error?.toString() ?? "Network error";
    } else {
      errorMessage = error.toString();
    }

    ToastUtil.showLongToast(errorMessage);
    dataFetcher.sink.addError(error);
    return false;
  }
}
