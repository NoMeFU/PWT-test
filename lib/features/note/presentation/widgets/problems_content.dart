// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:lawbug829/assets_healper/app_lottie.dart';
// import 'package:lawbug829/constants/text_font_style.dart';
// import 'package:lawbug829/features/note/model/get_problem_model.dart';
// import 'package:lawbug829/gen/assets.gen.dart';
// import 'package:lawbug829/gen/colors.gen.dart';
// import 'package:lawbug829/helpers/all_routes.dart';
// import 'package:lawbug829/helpers/navigation_service.dart';
// import 'package:lawbug829/helpers/ui_helpers.dart';
// import 'package:lawbug829/features/note/model/problems_model.dart';
// import 'package:lawbug829/networks/api_acess.dart';
// import 'package:lottie/lottie.dart';

// class ProblemsContent extends StatefulWidget {
//   final List<ProblemsModel> problemsList;

//   const ProblemsContent({
//     super.key,
//     required this.problemsList,
//   });

//   @override
//   State<ProblemsContent> createState() => _ProblemsContentState();
// }

// class _ProblemsContentState extends State<ProblemsContent> {
//   @override
//   void initState() {
//     super.initState();
//     getProblemApiRX.getProblemRx(); // Initial API call
//   }

//   String _formatDate(dynamic date) {
//     try {
//       DateTime parsedDate = DateTime.parse(date.toString());
//       return DateFormat('dd/MM/yyyy').format(parsedDate);
//     } catch (e) {
//       return date.toString(); // Fallback if parsing fails
//     }
//   }

//   // Function to handle pull-to-refresh
//   Future<void> _refreshProblems() async {
//     await getProblemApiRX.getProblemRx(); // Trigger API call on refresh
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<GetProblemModel>(
//       stream: getProblemApiRX.getProblemRX,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           var data = snapshot.data?.data;
//           return RefreshIndicator(
//             onRefresh: _refreshProblems, // Called when user pulls down
//             color: AppColors.cFF8E21, // Color of the refresh indicator
//             child: ListView.builder(
//               padding: EdgeInsets.symmetric(vertical: 16.h),
//               itemCount: data?.length ?? 0,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.only(bottom: 16.h),
//                   child: Container(
//                     padding: EdgeInsets.all(16.sp),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.r),
//                       color: AppColors.cFFF4E9,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             SvgPicture.asset(
//                               Assets.icons.calenderLawbug,
//                             ),
//                             UIHelper.horizontalSpace(4.w),
//                             Text(
//                               _formatDate(data![index].date),
//                               style: TextFontStyle
//                                   .headline12c637381stylepoppinsW400
//                                   .copyWith(
//                                 height: 1.83.h,
//                               ),
//                             ),
//                             const Spacer(),
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10.w, vertical: 4.h),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.r),
//                                 color: data[index].status == 'pending'
//                                     ? Colors.orange
//                                     : data[index].status == 'solve'
//                                         ? Colors.green
//                                         : data[index].status == 'cancel'
//                                             ? Colors.red
//                                             : Colors.amber, // Default color
//                               ),
//                               child: Text(
//                                 data[index].status.toString(),
//                                 style: TextFontStyle
//                                     .headline12c637381stylepoppinsW400
//                                     .copyWith(
//                                   color: AppColors.cFFFFFF,
//                                   height: 1.5.h,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ],
//                         ),
//                         UIHelper.verticalSpace(13.h),
//                         Text(
//                           data[index].description.toString(),
//                           style: TextFontStyle.headline14c919EABstylepoppinsW400
//                               .copyWith(
//                             height: 1.57.h,
//                           ),
//                         ),
//                         UIHelper.verticalSpace(16.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 NavigationService.navigateToWithArgs(
//                                     Routes.facingProblemDetailsScreen, {
//                                   "problemId": data[index].id,
//                                   "problemDescription": data[index].description,
//                                   "problemLocation": data[index].location,
//                                   "problemDate": data[index].date,
//                                   "problemStatus": data[index].status,
//                                   "problemFeedback": data[index].feedback,
//                                 });
//                               },
//                               child: Text(
//                                 'View Update',
//                                 style: TextFontStyle
//                                     .headline14cFF8E21stylepoppinsW600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         } else {
//           return Center(
//             child: Lottie.asset(
//               AppLottie.loading,
//             ),
//           );
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/note/model/get_problem_model.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/features/note/model/problems_model.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

class ProblemsContent extends StatefulWidget {
  final List<ProblemsModel> problemsList;

  const ProblemsContent({
    super.key,
    required this.problemsList,
  });

  @override
  State<ProblemsContent> createState() => _ProblemsContentState();
}

class _ProblemsContentState extends State<ProblemsContent> {
  @override
  void initState() {
    super.initState();
    getProblemApiRX.getProblemRx(); // Initial API call
  }

  String _formatDate(dynamic date) {
    try {
      DateTime parsedDate = DateTime.parse(date.toString());
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date.toString(); // Fallback if parsing fails
    }
  }

  // Function to handle pull-to-refresh
  Future<void> _refreshProblems() async {
    await getProblemApiRX.getProblemRx(); // Trigger API call on refresh
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetProblemModel>(
      stream: getProblemApiRX.getProblemRX,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.asset(
              AppLottie.loading,
              width: 150.w,
              height: 150.h,
            ),
          );
        } else if (snapshot.hasData) {
          var data = snapshot.data?.data ?? [];

          if (data.isEmpty) {
            return Center(
              child: Text(
                'No Problems Found',
                style: TextFontStyle.headline14c919EABstylepoppinsW400,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refreshProblems,
            color: AppColors.cFF8E21,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.cFFF4E9,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icons.calenderLawbug,
                            ),
                            UIHelper.horizontalSpace(4.w),
                            Text(
                              _formatDate(data[index].date),
                              style: TextFontStyle
                                  .headline12c637381stylepoppinsW400
                                  .copyWith(height: 1.83.h),
                            ),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: data[index].status == 'pending'
                                    ? Colors.orange
                                    : data[index].status == 'solve'
                                        ? Colors.green
                                        : data[index].status == 'cancel'
                                            ? Colors.red
                                            : Colors.amber,
                              ),
                              child: Text(
                                data[index].status.toString(),
                                style: TextFontStyle
                                    .headline12c637381stylepoppinsW400
                                    .copyWith(
                                  color: AppColors.cFFFFFF,
                                  height: 1.5.h,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(13.h),
                        Text(
                          data[index].description.toString(),
                          style: TextFontStyle.headline14c919EABstylepoppinsW400
                              .copyWith(height: 1.57.h),
                        ),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                NavigationService.navigateToWithArgs(
                                  Routes.facingProblemDetailsScreen,
                                  {
                                    "problemId": data[index].id,
                                    "problemDescription":
                                        data[index].description,
                                    "problemLocation": data[index].location,
                                    "problemDate": data[index].date,
                                    "problemStatus": data[index].status,
                                    "problemFeedback": data[index].feedback,
                                  },
                                );
                              },
                              child: Text(
                                'View Update',
                                style: TextFontStyle
                                    .headline14cFF8E21stylepoppinsW600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong',
              style: TextFontStyle.headline14c919EABstylepoppinsW400,
            ),
          );
        } else {
          return Center(
            child: Text(
              'No Problems Found',
              style: TextFontStyle.headline14c919EABstylepoppinsW400,
            ),
          );
        }
      },
    );
  }
}
