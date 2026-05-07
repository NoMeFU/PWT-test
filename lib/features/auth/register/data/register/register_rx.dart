// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lawbug829/constants/app_constants.dart';
import 'package:lawbug829/features/auth/register/data/register/register_api.dart';
import 'package:lawbug829/helpers/di.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';

// final class PostSignUpRX extends RxResponseInt {
//   final api = SignupApi.instance;
//   PostSignUpRX({required super.empty, required super.dataFetcher});

//   ValueStream get getFileData => dataFetcher.stream;

//   Future<bool> signup({
//     required dynamic employee_id,
//     required dynamic name,
//     required dynamic email,
//     required dynamic password,
//     required dynamic password_confirmation,
//     required dynamic current_location,
//     required dynamic lat,
//     required dynamic long,
//   }) async {
//     try {
//       Map data = await api.signupApi(
//         employee_id: employee_id,
//         name: name,
//         email: email,
//         password: password,
//         password_confirmation: password_confirmation,
//         current_location: current_location,
//         lat: lat,
//         long: long,
//       );
//       return handleSuccessWithReturn(data);
//     } catch (error) {
//       return handleErrorWithReturn(error);
//     }
//   }
// }

final class PostSignUpRX extends RxResponseInt<Map<String, dynamic>> {
  final api = SignupApi.instance;

  PostSignUpRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> signup({
    required dynamic employee_id,
    required dynamic name,
    required dynamic email,
    required dynamic password,
    required dynamic password_confirmation,
    required dynamic current_location,
    required dynamic lat,
    required dynamic long,
  }) async {
    try {
      Map<String, dynamic> data = await api.signupApi(
        employee_id: employee_id,
        name: name,
        email: email,
        password: password,
        password_confirmation: password_confirmation,
        current_location: current_location,
        lat: lat,
        long: long,
      );
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    // If token is expected and sometimes missing, use null check
    final token = data['data']?['token'];

    if (token != null) {
      appData.write(kKeyAccessToken, token);
      appData.write(kKeyIsLoggedIn, true);
      DioSingleton.instance.update(token);
    }

    // Still push the response data to stream
    dataFetcher.sink.add(data);

    return data;
  }


  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
