// ignore_for_file: unused_element, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/features/note/presentation/widgets/nested_tabbar_functionality.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              UIHelper.verticalSpace(24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTabWidget(
                    label: 'Daily Update',
                    isSelected: _currentIndex == 0,
                    onTap: () {
                      _buildShowDialog(context);
                    },
                    horizontalPadding: 4.w,
                  ),
                  CustomTabWidget(
                    label: 'Facing Problem',
                    isSelected: _currentIndex == 1,
                    onTap: () {
                      //_tabController.animateTo(1);
                      NavigationService.navigateTo(
                        Routes.addFacingProblemScreen,
                      );
                    },
                    horizontalPadding: 4.w,
                  ),
                ],
              ),
              const Expanded(
                child: ProblemListScreen(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> _buildShowDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 0.85.sh, // স্ক্রিনের 85% এর বেশি না
          ),
          child: const SingleChildScrollView(
            child: DailyWorkUpdateWidget(),
          ),
        ),
      );
    },
  );
}

class DailyWorkUpdateWidget extends StatefulWidget {
  const DailyWorkUpdateWidget({super.key});

  @override
  State<DailyWorkUpdateWidget> createState() => _DailyWorkUpdateWidgetState();
}

class _DailyWorkUpdateWidgetState extends State<DailyWorkUpdateWidget> {
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
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
        'task': 'Task ${index + 1}',
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

          customeButton(
            name: 'Submit',
            onCallBack: () {
              final List<Map<String, String>> tasks = _getTaskTexts();
              debugPrint('Tasks List: $tasks');
              NavigationService.navigateTo(Routes.updateDetailsScreen);
            },
            context: context,
          ),
        ],
      ),
    );
  }
}

class CustomTextFormFieldMax extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextFormFieldMax({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
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
        ),
        // Image removed to prevent focus issues on web
      ],
    );
  }
}
