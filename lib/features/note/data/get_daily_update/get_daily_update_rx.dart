import 'package:lawbug829/features/note/data/get_daily_update/get_daily_update_api.dart';
import 'package:lawbug829/features/note/model/get_daily_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../networks/rx_base.dart';

final class GetDailyUpdateApiRX extends RxResponseInt<GetDailyUpdateModel> {
  final api = GetDailyUpdateAPI.instance;

  GetDailyUpdateApiRX({required super.empty, required super.dataFetcher});

  ValueStream<GetDailyUpdateModel> get getDailyUpdateAPIRX =>
      dataFetcher.stream;

  Future<void> getDailyUpdateRx() async {
    try {
      GetDailyUpdateModel allData = await api.getDailyUpdateAPI();
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
