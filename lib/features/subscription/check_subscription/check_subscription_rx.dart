// ignore_for_file: depend_on_referenced_packages
import 'package:lawbug829/features/subscription/check_subscription/check_subscription_api.dart';
import 'package:lawbug829/features/subscription/model/subscription_check_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../networks/rx_base.dart';

final class GetSubscriptionCheckRX extends RxResponseInt<CheckSubscription> {
  final api = GetSubscriptionCheckAPI.instance;

  GetSubscriptionCheckRX({required super.empty, required super.dataFetcher});

  ValueStream<CheckSubscription> get getSubscriptionCheckRX =>
      dataFetcher.stream;

  Future<void> getSubscriptionRX() async {
    try {
      CheckSubscription allData = await api.getSubscriptionCheckAPI();
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(dynamic data) {
    dataFetcher.sink.add(data);
    return data;
  }
}
