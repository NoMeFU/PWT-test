import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:rxdart/streams.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class AttendanceApiRx extends RxResponseInt<Map<String, dynamic>> {
  final api = AttendanceApi.instance;

  AttendanceApiRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> attendanceInfo({
    required dynamic status,
    required dynamic role,
    required dynamic lat,
    required dynamic lang,
    required dynamic time,
  }) async {
    try {
      final data = await api.attendanceApiData(
        status: status,
        lang: lang,
        lat: lat,
        role: role,
        time: time,
      );
      await handleSuccessWithReturn(data);
      log('[AttendanceApiRx] ✅ attendanceInfo() — clock-in/out successful');
      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }



  @override
  handleErrorWithReturn(error) {
    log('[AttendanceApiRx] ❌ handleErrorWithReturn — error type: ${error.runtimeType}');
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
