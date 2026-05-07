// ignore_for_file: unused_local_variable

import 'package:lawbug829/features/note/data/get_problem_details/get_problem_details_api.dart';
import 'package:lawbug829/features/note/model/get_problem_details.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../networks/rx_base.dart';

final class GetProblemDetailsApiRX
    extends RxResponseInt<GetProblemDetailsModel> {
  final api = GetProblemDetailsApi.instance;

  GetProblemDetailsApiRX({required super.empty, required super.dataFetcher});

  ValueStream<GetProblemDetailsModel> get getProblemDetailsRX =>
      dataFetcher.stream;

  Future<void> getProblemDetailRx({
    required dynamic id,
  }) async {
    try {
      GetProblemDetailsModel allData = await api.getProblemDetailsApi(id: id);
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
