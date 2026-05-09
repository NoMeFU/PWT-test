// ignore_for_file: dead_code, unused_element
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

// * After Checkout Dialog
class HomeCheckoutDialog extends StatefulWidget {
  final dynamic id;
  const HomeCheckoutDialog({super.key, required this.id});

  @override
  State<HomeCheckoutDialog> createState() => _HomeCheckoutDialogState();
}

class _HomeCheckoutDialogState extends State<HomeCheckoutDialog> {
  bool isLoading = false;
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    log(">>>>>>>>>>>>>>>>>>>>>> Here is the last attendance ID:- ${widget.id.toString()}");

    super.initState();
    _addTask();
    _addTask();
  }

  void _addTask() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  List<Map<String, String>> _getTaskTexts() {
    return List.generate(_controllers.length, (index) {
      return {
        'task_name': 'Task ${index + 1}', // Changed from 'task' to 'task_name'
        'description': _controllers[index].text,
      };
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        color: AppColors.cFFFFFF,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Daily Work’s Update',
              style: TextFontStyle.headline20c212B36stylepoppinsW500.copyWith(
                height: 1.5.h,
              ),
            ),
          ),
          UIHelper.verticalSpace(10.h),
          Divider(
            thickness: 1.w,
            color: AppColors.cF2F2F2,
          ),
          UIHelper.verticalSpace(24.h),

          // Tasks List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _controllers.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        'Task ${index + 1}',
                        style: TextFontStyle.headline20c212B36stylepoppinsW500
                            .copyWith(fontSize: 16.sp, height: 1.5.h),
                      ),
                      const Spacer(),
                      if (index == _controllers.length - 1)
                        GestureDetector(
                          onTap: _addTask,
                          child: SvgPicture.asset(Assets.icons.circlePlus),
                        ),
                    ],
                  ),
                  UIHelper.verticalSpace(10.h),
                  CustomTextFormFieldMax(
                    controller: _controllers[index],
                  ),
                  UIHelper.verticalSpace(16.h),
                ],
              );
            },
          ),

          UIHelper.verticalSpace(20.h),

          isLoading
              ? Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFFF,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.cFF8E21,
                      width: 2,
                    ),
                  ),
                  child: Lottie.asset(
                    AppLottie.loading,
                    height: 100,
                    width: 100,
                  ),
                )
              : customeButton(
                  name: 'Submit',
                  onCallBack: () async {
                    setState(() {
                      isLoading = true; // Start loading
                    });
                    final List<Map<String, String>> tasks = _getTaskTexts();
                    debugPrint('Tasks sent to API: $tasks');
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                    debugPrint(formattedDate);

                    bool isSuccess =
                        await postCheckoutNoteApiRXObj.postCheckoutNoteRX(
                      task_date: formattedDate,
                      tasks: tasks,
                      employee_checking_id: widget.id.toString(),
                    );

                    if (isSuccess) {
                      setState(() {
                        isLoading = false; // Start loading
                      });
                      Navigator.pop(context);
                      ToastUtil.showShortToast(
                          'Checkout Note Submitted Successfully');
                    } else {
                      ToastUtil.showShortToast(
                          'Failed to Submit Checkout Note');
                    }
                  },
                  context: context,
                ),
        ],
      ),
    );
  }
}

// * Custom Text Form Field with Max Lines
class CustomTextFormFieldMax extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextFormFieldMax({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
    );
  }
}
