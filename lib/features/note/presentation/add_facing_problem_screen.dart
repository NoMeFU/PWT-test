// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:lawbug829/common_widget/custom_app_bar.dart';
// import 'package:lawbug829/common_widget/custom_button.dart';
// import 'package:lawbug829/common_widget/custom_text_field.dart';
// import 'package:lawbug829/constants/text_font_style.dart';
// import 'package:lawbug829/gen/assets.gen.dart';
// import 'package:lawbug829/gen/colors.gen.dart';
// import 'package:lawbug829/helpers/all_routes.dart';
// import 'package:lawbug829/helpers/navigation_service.dart';
// import 'package:lawbug829/helpers/ui_helpers.dart';
// import 'package:lawbug829/networks/api_acess.dart';

// class AddFacingProblemScreen extends StatefulWidget {
//   const AddFacingProblemScreen({super.key});

//   @override
//   State<AddFacingProblemScreen> createState() => _AddFacingProblemScreenState();
// }

// class _AddFacingProblemScreenState extends State<AddFacingProblemScreen> {
//   final _dateController = TextEditingController();
//   final _locationController = TextEditingController();
//   final _decriptionController = TextEditingController();

//   Future<void> _selectDate(BuildContext context) async {
//     FocusScope.of(context).unfocus(); // Hide keyboard
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null) {
//       _dateController.text =
//           "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: Text('Add Facing Problem',
//             style: TextFontStyle.headline20c212B36stylepoppinsW500),
//         leading: GestureDetector(
//           onTap: () {
//             NavigationService.goBack;
//           },
//           child: Padding(
//             padding: EdgeInsets.only(left: 16.w),
//             child: SvgPicture.asset(
//               Assets.icons.arrowBackLawbug,
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           UIHelper.customDivider(color: AppColors.cDFE3E8),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: Column(
//               children: [
//                 UIHelper.verticalSpace(16.h),
//                 Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Text(
//                     'Date of Problem',
//                     style: TextFontStyle.headline20c212B36stylepoppinsW500
//                         .copyWith(fontSize: 14.sp, height: 2.57.h),
//                   ),
//                 ),
//                 UIHelper.verticalSpace(6.h),
//                 CustomTextField(
//                   controller: _dateController,
//                   hintText: 'Enter Date of Problem',
//                   suffixIcon: Assets.icons.calenderLawbug,
//                   readOnly: true,
//                   onTap: () => _selectDate(context),
//                   validator: (v) {
//                     if (v == null || v.trim().isEmpty) {
//                       return 'Date of Problem is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 UIHelper.verticalSpace(10.h),
//                 Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Text(
//                     'Location',
//                     style: TextFontStyle.headline20c212B36stylepoppinsW500
//                         .copyWith(fontSize: 14.sp, height: 2.57.h),
//                   ),
//                 ),
//                 UIHelper.verticalSpace(6.h),
//                 CustomTextField(
//                   controller: _locationController,
//                   hintText: 'Enter Location',
//                   suffixIcon: Assets.icons.detectLocationLawbug,
//                   validator: (v) {
//                     if (v == null || v.trim().isEmpty) {
//                       return 'Full name is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 UIHelper.verticalSpace(32.h),
//                 Row(
//                   children: [
//                     Container(
//                       width: 4.w,
//                       height: 20.h,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4.r),
//                         color: AppColors.cFF8E21,
//                       ),
//                     ),
//                     UIHelper.horizontalSpace(10.w),
//                     Text(
//                       'Problem Description',
//                       style: TextFontStyle.headline20c212B36stylepoppinsW500
//                           .copyWith(fontSize: 16.sp, height: 1.5.h),
//                     ),
//                   ],
//                 ),
//                 UIHelper.verticalSpace(16.h),
//                 TextFormField(
//                   controller: _decriptionController,
//                   cursorColor: AppColors.cFF8E21,
//                   cursorRadius: Radius.circular(8.r),
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.r),
//                       borderSide: const BorderSide(
//                         color: AppColors.cFF8E21,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.r),
//                       borderSide: const BorderSide(
//                         color: AppColors.cFF8E21,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.r),
//                       borderSide: const BorderSide(
//                         color: AppColors.cFF8E21,
//                       ),
//                     ),
//                     fillColor: AppColors.cFFF4E9,
//                     filled: true,
//                     contentPadding: EdgeInsets.all(16.w),
//                   ),
//                   minLines: 5,
//                   maxLines: 5,
//                 ),
//                 UIHelper.verticalSpace(173.h),
//                 customeButton(
//                   name: 'Submit',
//                   context: context,
//                   onCallBack: () async {
//                     bool isSuccess = await postProblemApiRXObj.postProblemRX(
//                       description: _decriptionController.text.trim(),
//                       location: _locationController.text.trim(),
//                       date: _dateController.text.trim(),
//                     );

//                     if (isSuccess) {
//                       // * Show GetX snackbar on top
//                       Get.snackbar(
//                         'Success',
//                         'Issue submitted successfully.',
//                         snackPosition: SnackPosition.TOP,
//                         backgroundColor: Colors.green,
//                         colorText: Colors.white,
//                         duration: const Duration(seconds: 3),
//                         margin: const EdgeInsets.all(10),
//                         borderRadius: 10,
//                       );
//                       // * NavigationService.goBack;
//                       NavigationService.navigateTo(
//                         Routes.facingProblemDetailsScreen,
//                       );
//                     } else {
//                       // * Show default snackbar on bottom for error
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text(
//                             'Failed to send complain.',
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/common_widget/custom_text_field.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';

class AddFacingProblemScreen extends StatefulWidget {
  const AddFacingProblemScreen({super.key});

  @override
  State<AddFacingProblemScreen> createState() => _AddFacingProblemScreenState();
}

class _AddFacingProblemScreenState extends State<AddFacingProblemScreen> {
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _decriptionController = TextEditingController();

  // Variable to control the loading screen visibility
  bool _isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).unfocus(); // Hide keyboard
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _dateController.text =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    }
  }

  // Show loading screen
  void _showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  // Hide loading screen
  void _hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Add Facing Problem',
            style: TextFontStyle.headline20c212B36stylepoppinsW500),
        leading: GestureDetector(
          onTap: () {
            NavigationService.goBack();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: SvgPicture.asset(
              Assets.icons.arrowBackLawbug,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // The main content of the screen
          Column(
            children: [
              UIHelper.customDivider(color: AppColors.cDFE3E8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    UIHelper.verticalSpace(16.h),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Date of Problem',
                        style: TextFontStyle.headline20c212B36stylepoppinsW500
                            .copyWith(fontSize: 14.sp, height: 2.57.h),
                      ),
                    ),
                    UIHelper.verticalSpace(6.h),
                    CustomTextField(
                      controller: _dateController,
                      hintText: 'Enter Date of Problem',
                      suffixIcon: Assets.icons.calenderLawbug,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Date of Problem is required';
                        }
                        return null;
                      },
                    ),
                    UIHelper.verticalSpace(10.h),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Location',
                        style: TextFontStyle.headline20c212B36stylepoppinsW500
                            .copyWith(fontSize: 14.sp, height: 2.57.h),
                      ),
                    ),
                    UIHelper.verticalSpace(6.h),
                    CustomTextField(
                      controller: _locationController,
                      hintText: 'Enter Location',
                      suffixIcon: Assets.icons.detectLocationLawbug,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Full name is required';
                        }
                        return null;
                      },
                    ),
                    UIHelper.verticalSpace(32.h),
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
                          'Problem Description',
                          style: TextFontStyle.headline20c212B36stylepoppinsW500
                              .copyWith(fontSize: 16.sp, height: 1.5.h),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(16.h),
                    TextFormField(
                      controller: _decriptionController,
                      cursorColor: AppColors.cFF8E21,
                      cursorRadius: Radius.circular(8.r),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.cFF8E21,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.cFF8E21,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.cFF8E21,
                          ),
                        ),
                        fillColor: AppColors.cFFF4E9,
                        filled: true,
                        contentPadding: EdgeInsets.all(16.w),
                      ),
                      minLines: 5,
                      maxLines: 5,
                    ),
                    UIHelper.verticalSpace(173.h),
                    customeButton(
                      name: 'Submit',
                      context: context,
                      onCallBack: () async {
                        _showLoading(); // Show the loading screen

                        bool isSuccess =
                            await postProblemApiRXObj.postProblemRX(
                          description: _decriptionController.text.trim(),
                          location: _locationController.text.trim(),
                          date: _dateController.text.trim(),
                        );

                        _hideLoading(); // Hide the loading screen

                        if (isSuccess) {
                          // * Show GetX snackbar on top
                          Get.snackbar(
                            'Success',
                            'Issue submitted successfully.',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 3),
                            margin: const EdgeInsets.all(10),
                            borderRadius: 10,
                          );
                          // * NavigationService.goBack;
                          NavigationService.navigateTo(
                            Routes.facingProblemDetailsScreen,
                          );
                        } else {
                          // * Show default snackbar on bottom for error
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Failed to send complain.',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Full screen loading indicator
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.cFF8E21,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
