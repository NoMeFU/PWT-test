import 'package:lawbug829/features/report/data/get_expense_api.dart';
import 'package:lawbug829/features/report/model/expense_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../networks/rx_base.dart';

final class GetExpenseAPIRX extends RxResponseInt<ExpenseModel> {
  final api = GetExpenseAPI.instance;

  GetExpenseAPIRX({required super.empty, required super.dataFetcher});

  ValueStream<ExpenseModel> get getExpenseApi => dataFetcher.stream;

  Future<void> expenseAPIRX() async {
    try {
      ExpenseModel allData = await api.expenseAPI();
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
