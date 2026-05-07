// ignore_for_file: unused_field
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/report/model/working_report_model.dart';
import 'package:lawbug829/features/report/presentation/checkin_list_screen.dart';
import 'package:lawbug829/features/report/presentation/expense_list_screen.dart';
import 'package:lawbug829/features/subscription/model/subscription_check_model.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // * Call API
    getSubscriptionCheckRXObj.getSubscriptionCheckRX;
    getReportAPIRX.reportAPIRX();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.verticalSpace(20.h),
                  // * Income and Expense Card
                  StreamBuilder<GetReportModel>(
                      stream: getReportAPIRX.dataFetcher,
                      builder: (context, snapshot) {
                        var earningMoney =
                            snapshot.data?.data?.totalEarning.toString();
                        var expenseMoney =
                            snapshot.data?.data?.totalExpense.toString();
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildMoneyContainer(
                                  title: 'Earning Money',
                                  amount: earningMoney ?? '0.00',
                                  showAddButton: false,
                                  onAddPressed: () {
                                    // Handle Add Earning
                                  },
                                ),
                                UIHelper.horizontalSpace(16.w),
                                StreamBuilder<CheckSubscription>(
                                    stream:
                                        getSubscriptionCheckRXObj.dataFetcher,
                                    builder: (context, snapshot) {
                                      var isSubscribed =
                                          snapshot.data?.data?.isSubscribed ??
                                              false;
                                      log(">>>>>>>>>>>>>>>>>>>>>>>> Is Subscribed: $isSubscribed");
                                      return _buildMoneyContainer(
                                        title: 'Expense Money',
                                        amount: expenseMoney ?? '0.00',
                                        showAddButton: true,
                                        onAddPressed: () {
                                          if (isSubscribed == false) {
                                            NavigationService.navigateTo(
                                              Routes.subscriptionScreen,
                                            );
                                            return;
                                          }
                                          NavigationService.navigateTo(
                                            Routes.addExpenseMoneyScreen,
                                          );
                                        },
                                      );
                                    }),
                              ],
                            ),
                            UIHelper.verticalSpace(16.h),
                            StreamBuilder<GetReportModel>(
                                stream: getReportAPIRX.dataFetcher,
                                builder: (context, snapshot) {
                                  var totalDutyTimeYears = snapshot
                                      .data?.data?.totalDutyTime?.years
                                      .toString();
                                  var totalDutyTimeDays = snapshot
                                      .data?.data?.totalDutyTime?.days
                                      .toString();
                                  var totalDutyTimeMinutes = snapshot
                                      .data?.data?.totalDutyTime?.minutes
                                      .toString();

                                  log(">>>>>>>>>>>>>>>>>>>>>>>> Total Duty Time: $totalDutyTimeYears years, $totalDutyTimeDays days, $totalDutyTimeMinutes minutes");
                                  return Container(
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFFFC8C20),
                                          Color(0xFFFFC083)
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Total Duty Time',
                                            style: TextFontStyle
                                                .headline8cFFFFFFstylepoppinsW500),
                                        UIHelper.verticalSpace(16.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            _buildDutyTimeItem('Year',
                                                totalDutyTimeYears ?? '0'),
                                            _buildDutyTimeItem('Days',
                                                totalDutyTimeDays ?? '0'),
                                            _buildDutyTimeItem('Minute',
                                                totalDutyTimeMinutes ?? '0'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        );
                      }),

                  UIHelper.verticalSpace(12.h),
                  Row(
                    children: [
                      Container(
                        width: 4.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: AppColors.cFF8E21,
                        ),
                      ),
                      UIHelper.horizontalSpace(10.w),
                      Text(
                        'Worker\'s History',
                        style: TextFontStyle.headline16c212B36stylepoppinsW600
                            .copyWith(height: 1.5.h),
                      ),
                    ],
                  ),
                  // UIHelper.verticalSpace(16.h),
                  // CustomTextField(
                  //   controller: _searchController,
                  //   hintText: 'Search here',
                  //   prefixIcon: Assets.icons.searchLawbug,
                  //   suffixIcon: Assets.icons.filterOrangeLawbug,
                  // ),
                  UIHelper.verticalSpace(12.h),
                ],
              ),
            ),

            /// Tab Bar
            TabBar(
              controller: _tabController,
              labelColor: AppColors.cFF8E21,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.cFF8E21,
              labelStyle: TextFontStyle.headline16c212B36stylepoppinsW600,
              unselectedLabelStyle:
                  TextFontStyle.headline16c212B36stylepoppinsW600,
              tabs: const [
                Tab(text: 'Check-In'),
                Tab(text: 'Expenses'),
              ],
            ),

            /// Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  CheckInListScreen(),
                  ExpenseListScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // * Reusable Money Container
  Widget _buildMoneyContainer({
    required String title,
    required String amount,
    required bool showAddButton,
    VoidCallback? onAddPressed,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFC8C20), Color(0xFFFFC083)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: TextFontStyle.headline8cFFFFFFstylepoppinsW500
                        .copyWith(fontSize: 14)),
                if (showAddButton)
                  InkWell(
                    onTap: onAddPressed,
                    child: SvgPicture.asset(
                      Assets.icons.addIconLawbug,
                      color: AppColors.cFFFFFF,
                    ),
                  ),
              ],
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              'Total',
              style: TextFontStyle.headline8cFFFFFFstylepoppinsW500.copyWith(
                fontSize: 14,
              ),
            ),
            UIHelper.verticalSpace(3.h),
            Text(
              amount,
              style: TextFontStyle.headline22cFFFFFFstylepoppinsW700
                  .copyWith(height: 1.32.h),
            ),
          ],
        ),
      ),
    );
  }

  // * Reusable Duty Time Item
  Widget _buildDutyTimeItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextFontStyle.headline8cFFFFFFstylepoppinsW500.copyWith(
              fontSize: 14,
            ),
          ),
          UIHelper.verticalSpace(4.h),
          Text(
            value,
            style: TextFontStyle.headline22cFFFFFFstylepoppinsW700.copyWith(
              height: 1.32.h,
            ),
          ),
        ],
      ),
    );
  }
}
