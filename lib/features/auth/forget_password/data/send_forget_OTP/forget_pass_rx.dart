// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages
import 'package:lawbug829/features/auth/forget_password/data/send_forget_OTP/forget_pass_api.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';

final class PostForgetPassRX extends RxResponseInt {
  final api = PostForgetApi.instance;

  PostForgetPassRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<dynamic> forgetAPI({
    required String email,
  }) async {
    try {
      Map data = await api.forget(
        email: email,
      );
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }
}
