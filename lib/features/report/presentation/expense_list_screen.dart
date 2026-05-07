import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/report/model/expense_model.dart';
import 'package:lawbug829/features/report/presentation/widgets/expanse_report_card.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  @override
  void initState() {
    super.initState();
    getExpenseAPIRX.expenseAPIRX();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              StreamBuilder<ExpenseModel>(
                stream: getExpenseAPIRX.getExpenseApi,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error loading data'),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;

                    // ignore: unused_local_variable
                    final expenseHistory = data?.data ?? [];
                    // Format it to dd/MM/yyyy
                    if (expenseHistory.isEmpty) {
                      return Center(
                        child: Text(
                          'No expense history available',
                          style:
                              TextFontStyle.headline14c919EABstylepoppinsW400,
                        ),
                      );
                    }
                    return expenseHistory.isEmpty
                        ? const SizedBox.shrink()
                        : ListView.builder(
                            itemCount: expenseHistory.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              String formattedDate = DateFormat('dd/MM/yyyy')
                                  .format(
                                      expenseHistory[0].date ?? DateTime.now());

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ExpanseReportCard(
                                  date: formattedDate,
                                  expenseMoney: expenseHistory[index]
                                          .amountSpent
                                          ?.toString() ??
                                      'N/A',
                                  location: expenseHistory[index]
                                          .location
                                          ?.toString() ??
                                      'N/A',
                                  category: expenseHistory[index]
                                          .category
                                          ?.toString() ??
                                      'N/A',
                                  paymentMethod: expenseHistory[index]
                                          .paymentMethod
                                          ?.toString() ??
                                      'N/A',
                                  attachment:
                                      expenseHistory[index].file?.toString() ??
                                          'N/A',
                                  note: expenseHistory[index]
                                          .description
                                          ?.toString() ??
                                      'N/A',
                                ),
                              );
                            },
                          );
                  } else {
                    return Center(
                      child: Lottie.asset(
                        AppLottie.loading,
                        width: 100.w,
                        height: 100.h,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
