import 'package:lawbug829/features/note/data/get_daily_update_details/get_daily_update_details_api.dart';
import 'package:lawbug829/features/note/model/get_daily_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../networks/rx_base.dart';

final class GetDailyUpdateDetailsApiRX
    extends RxResponseInt<GetDailyUpdateModel> {
  final api = GetDailyUpdateDetailsAPI.instance;

  GetDailyUpdateDetailsApiRX(
      {required super.empty, required super.dataFetcher});

  ValueStream<GetDailyUpdateModel> get getDailyUpdateDetailsRX =>
      dataFetcher.stream;

  Future<void> getDailyUpdateDetailsRx({required id}) async {
    try {
      GetDailyUpdateModel allData =
          await api.getUpdateDetailsAPI();
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
