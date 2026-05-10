// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api
// * ###############################################################################
// * ###############################################################################
// * ###############################################################################
// * ###############################################################################
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/report/model/working_report_model.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:intl/intl.dart';
import 'package:lawbug829/helpers/geocoding_helper.dart';
import 'package:lottie/lottie.dart';

class CheckInListScreen extends StatefulWidget {
  const CheckInListScreen({super.key});

  @override
  State<CheckInListScreen> createState() => _CheckInListScreenState();
}

class _CheckInListScreenState extends State<CheckInListScreen> {
  @override
  void initState() {
    super.initState();
    getReportAPIRX.reportAPIRX(); // Trigger API call
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<GetReportModel>(
          stream: getReportAPIRX.dataFetcher,
          builder: (context, snapshot) {
            // * 1. Loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset(
                  AppLottie.loading,
                  width: 100.w,
                  height: 100.h,
                ),
              );
            }

            // * 2. Error state
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong!"));
            }

            // * 3. Empty or no data state
            if (!snapshot.hasData ||
                snapshot.data!.data == null ||
                snapshot.data!.data!.chackingHistory == null ||
                snapshot.data!.data!.chackingHistory!.isEmpty) {
              return Center(
                  child: Text(
                "No check-in data found",
                style: TextFontStyle.headline14c919EABstylepoppinsW400,
              ));
            }

            // * 4. Data found
            final checkingHistory = snapshot.data!.data!.chackingHistory!;

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: checkingHistory.length,
              itemBuilder: (context, index) {
                final history = checkingHistory[index];
                final check = history.employeeChecking;

                String formattedDate = 'N/A';
                String checkInTime = 'N/A';
                String checkOutTime = 'N/A';

                try {
                  if (history.earningDate != null) {
                    formattedDate =
                        DateFormat('dd/MM/yyyy').format(history.earningDate!);
                  }
                  if (check?.checkIn != null) {
                    checkInTime = DateFormat('hh:mm a').format(check!.checkIn!);
                  }
                  if (check?.checkOut != null) {
                    checkOutTime =
                        DateFormat('hh:mm a').format(check!.checkOut!);
                  }
                } catch (e) {
                  debugPrint('Date parse error: $e');
                }

                var Lat = check?.lat;
                var Long = check?.long;

                return InkWell(
                  splashColor: Colors.amber,
                  onTap: () {},
                  child: WorkingReportCard(
                    // * First Item showing on List
                    working_hours: history.workingHours
                        .toString(), // * use checking history list from API
                    check_in:
                        checkInTime, // * use employee_checking list from API
                    check_out:
                        checkOutTime, // * use employee_checking list from API
                    checkin_date:
                        formattedDate, // * use checking history list from API
                    lat: Lat, // * use employee_checking list from API
                    long: Long, // * use employee_checking list from API
                    employeeRole: history.role,
                    salary: history.salary,
                    tax: history.vat,
                    totalSalary: history.totalSalary,
                    employeeID: history.userId,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class WorkingReportCard extends StatefulWidget {
  final dynamic working_hours;
  final dynamic check_in;
  final dynamic check_out;
  final dynamic checkin_date;
  final dynamic lat, long;
  final dynamic employeeRole;
  final dynamic salary;
  final dynamic tax;
  final dynamic totalSalary;
  final dynamic employeeID;

  const WorkingReportCard({
    super.key,
    required this.working_hours,
    required this.check_in,
    required this.check_out,
    required this.checkin_date,
    required this.lat,
    required this.long,
    required this.employeeRole,
    required this.salary,
    required this.tax,
    required this.totalSalary,
    required this.employeeID,
  });

  @override
  _WorkingReportCardState createState() => _WorkingReportCardState();
}

class _WorkingReportCardState extends State<WorkingReportCard> {
  String location = 'Loading...'; // Initially show 'Loading...'

  @override
  void initState() {
    super.initState();
    _getAddress(widget.lat, widget.long); // Get address from lat & long
  }

  // Function to fetch address from latitude and longitude
  Future<void> _getAddress(double? Lat, double? Long) async {
    if (Lat == null || Long == null) return;

    try {
      List<dynamic> placemarks = await GeocodingHelper.placemarkFromCoordinates(Lat, Long);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          location = [
            place.street,
            place.locality,
            place.administrativeArea,
            place.country
          ]
              .where((e) => e != null && e.isNotEmpty)
              .join(', '); // Update location after fetching address
        });
      } else {
        setState(() {
          location = 'Unknown Location'; // In case no address is found
        });
      }
    } catch (e) {
      debugPrint('Location error: $e');
      setState(() {
        location = 'Invalid Location'; // Error while fetching location
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.cFFF4E9,
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(Assets.icons.calenderLawbug),
                UIHelper.horizontalSpace(8.w),
                Text(
                  widget.checkin_date ?? 'N/A',
                  style: TextFontStyle.headline12c637381stylepoppinsW400
                      .copyWith(height: 1.83.h),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    NavigationService.navigateToWithArgs(
                        Routes.paycheckScreen, {
                      'date': widget.checkin_date,
                      'working_hours': widget.working_hours,
                      'checkIn': widget.check_in,
                      'checkOut': widget.check_out,
                      'location': location,
                      'totalWorkTime': widget.working_hours,
                      'role': widget.employeeRole,
                      'salary': widget.salary,
                      'tax': widget.tax.toString(),
                      'totalSalary': widget.totalSalary.toString(),
                      'employeeID': widget.employeeID.toString(),
                    });
                  },
                  child: Text(
                    'View Update',
                    style: TextFontStyle.headline14cFF8E21stylepoppinsW600,
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(6.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(Assets.icons.locationOrangeLawbug),
                UIHelper.horizontalSpace(4.w),
                Expanded(
                  child: Text(
                    location, // This will now display the updated location
                    style: TextFontStyle.headline14c212B36stylepoppinsW400
                        .copyWith(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.working_hours ?? 'N/A',
                  style: TextFontStyle.headline12c637381stylepoppinsW400,
                ),
              ],
            ),
            UIHelper.verticalSpace(16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: SvgPicture.asset(Assets.icons.arrowDownGreen),
                ),
                UIHelper.horizontalSpace(4.w),
                Column(
                  children: [
                    Text(
                      'Check In',
                      style: TextFontStyle.headline16c919EABstylepoppinsW400
                          .copyWith(
                        fontSize: 14.sp,
                        color: AppColors.c22BB33,
                      ),
                    ),
                    UIHelper.verticalSpace(4.h),
                    Text(
                      widget.check_in ?? 'N/A',
                      style: TextFontStyle.headline32c212B36stylepoppinsW700
                          .copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.c454F5B,
                        height: 1.83.h,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: SvgPicture.asset(Assets.icons.arrowUpRed),
                ),
                UIHelper.horizontalSpace(4.w),
                Column(
                  children: [
                    Text(
                      'Check Out',
                      style: TextFontStyle.headline16c919EABstylepoppinsW400
                          .copyWith(
                        fontSize: 14.sp,
                        color: AppColors.cFF4842,
                      ),
                    ),
                    UIHelper.verticalSpace(4.h),
                    Text(
                      widget.check_out ?? 'N/A',
                      style: TextFontStyle.headline32c212B36stylepoppinsW700
                          .copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.c454F5B,
                        height: 1.83.h,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
