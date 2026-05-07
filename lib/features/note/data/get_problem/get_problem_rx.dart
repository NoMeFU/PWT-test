import 'package:lawbug829/features/note/data/get_problem/get_problem_api.dart';
import 'package:lawbug829/features/note/model/get_problem_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../networks/rx_base.dart';

final class GetProblemApiRX extends RxResponseInt<GetProblemModel> {
  final api = GetProblemApi.instance;

  GetProblemApiRX({required super.empty, required super.dataFetcher});

  ValueStream<GetProblemModel> get getProblemRX => dataFetcher.stream;

  Future<void> getProblemRx() async {
    try {
      GetProblemModel allData = await api.getProblemAPI();
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
