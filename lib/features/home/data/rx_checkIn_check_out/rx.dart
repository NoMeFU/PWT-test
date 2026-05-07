import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/features/home/model/check_in_check_out_data_model.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../constants/app_constants.dart' show kKeyIsLoggedIn;
import '../../../../helpers/di.dart' show appData;
import '../../../../helpers/toast.dart' show ToastUtil;
import 'api.dart';


final class CheckInCheckOutRx extends RxResponseInt<CheckInCheckOutDataModel> {
  final api = CheckInCheckOutApi.instance;

  CheckInCheckOutRx({required super.empty, required super.dataFetcher});

  ValueStream get getAvailableItemsStream => dataFetcher.stream;

  Future<CheckInCheckOutDataModel?> checkInCheckOutInfo() async {
    try {
      final data = await api.checkInCheckOutData();
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

