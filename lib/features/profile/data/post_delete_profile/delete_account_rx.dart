import 'dart:developer';
import 'package:lawbug829/features/profile/data/post_delete_profile/delete_account_api.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';

final class DeleteAccountApiRX extends RxResponseInt {
  final api = DeleteAccountApi.instance;

  String message = "Something went wrong";

  DeleteAccountApiRX({required super.empty, required super.dataFetcher});

  ValueStream get deleteAccRx => dataFetcher.stream;

  Future<bool> deleteAccount() async {
    try {
      Map resdata = await api.deleteAccount();
      return handleSuccessWithReturn(resdata);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) {
    dataFetcher.sink.add(data);
    log(">>>>>>>>>>>>>>>>>>> Delete success");
    ToastUtil.showShortToast("Account Delete successful");
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String errorMessage = 'Something went wrong';
    log(error.toString());

    errorMessage = error.response?.data["message"] ?? "Something went wrong";
    return super.handleErrorWithReturn(errorMessage);
  }
}
