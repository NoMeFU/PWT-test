import 'dart:developer';
import 'package:get/get.dart';
import 'package:lawbug829/constants/app_constants.dart';
import 'package:lawbug829/features/social_login/social_login_api.dart';
import 'package:lawbug829/helpers/di.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/exception_handler/data_source.dart';
import 'package:lawbug829/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class PostGoogleLoginRX extends RxResponseInt<Map> {
  final api = PostGoogleLoginApi.instance;
  String message = "Can't login!".tr;

  PostGoogleLoginRX({required super.empty, required super.dataFetcher});

  ValueStream get getSocaialLoginRes => dataFetcher.stream;

  Future<Map> postGoogleLogin({
    required String registerType,
    required String token,
  }) async {
    try {
      Map resdata = await api.postSocialLogin(
        token: token,
        provider: registerType,
      );
      log(" from response : $resdata");
      return handleSuccessWithReturn(resdata);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  Future<Map> handleSuccessWithReturn(Map data) async {
    message = data["message"];
    if (data["success"] == true) {
      String accesstoken = data["token"];
      log('rx token $accesstoken');
      String id = data["data"]["id"].toString();

      // * Save user data to appData
      await appData.write(kKeyIsLoggedIn, true);
      await appData.write(kKeyAccessToken, accesstoken);
      await appData.write(kKeyUserID, id);

      // * Update Dio Singleton with new access token
      DioSingleton.instance.update(accesstoken);
      dataFetcher.sink.add(data);
      return data;
    } else {
      throw DataSource.DEFAULT.getFailure();
    }
  }

}
