import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/home/model/home_attendance_and_user_info_data.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../constants/app_constants.dart' show kKeyIsLoggedIn;
import '../../../../helpers/di.dart' show appData;
import '../../../../helpers/toast.dart' show ToastUtil;
import 'api.dart';

final class HomeUserAndAttendanceRx
    extends RxResponseInt<HomeUserAndAttendanceDataModel> {
  final api = HomeUserAndAttendanceApi.instance;

  HomeUserAndAttendanceRx({required super.empty, required super.dataFetcher});

  ValueStream get getAvailableItemsStream => dataFetcher.stream;

  Future<HomeUserAndAttendanceDataModel?> attendanceAndUserInfo() async {
    try {
      final data = await api.attendanceAndUserData();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final errorMessage = error.response?.data?["error"] ??
          error.response?.data?["message"] ??
          "An unknown error occurred.";

      if (statusCode == 401) {
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateTo(Routes.signInScreen);
      } else {
        ToastUtil.showShortToast(errorMessage);
      }
    } else {
      ToastUtil.showShortToast("An unexpected error occurred.");
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }
}
