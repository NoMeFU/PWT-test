import 'package:lawbug829/features/profile/data/get_profile_info/get_profile_api.dart';
import 'package:lawbug829/features/profile/model/profile_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../networks/rx_base.dart';

final class GetProfileRX extends RxResponseInt<ProfileModel> {
  final api = GetProfileApi.instance;

  GetProfileRX({required super.empty, required super.dataFetcher});

  ValueStream<ProfileModel> get getProfileRX => dataFetcher.stream;

  Future<void> profile() async {
    try {
      ProfileModel allData = await api.course();
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
