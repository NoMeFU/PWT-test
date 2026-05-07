import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/note/model/daily_update_model.dart';
import 'package:lawbug829/features/note/model/problems_model.dart';
import 'package:lawbug829/features/note/presentation/widgets/daily_update_content.dart';
import 'package:lawbug829/features/note/presentation/widgets/problems_content.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class ProblemListScreen extends StatelessWidget {
  const ProblemListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<DailyUpdateModel> dailyUpdates = [
      DailyUpdateModel(
        date: '12/04/2025',
        location: 'Dhaka, Bangladesh',
        duration: '08 Hours 2min',
      ),
      DailyUpdateModel(
        date: '12/04/2025',
        location: 'Dhaka, Bangladesh',
        duration: '08 Hours 2min',
      ),
      DailyUpdateModel(
        date: '12/04/2025',
        location: 'Dhaka, Bangladesh',
        duration: '08 Hours 2min',
      ),
      DailyUpdateModel(
        date: '12/04/2025',
        location: 'Dhaka, Bangladesh',
        duration: '08 Hours 2min',
      ),
      DailyUpdateModel(
        date: '12/04/2025',
        location: 'Dhaka, Bangladesh',
        duration: '08 Hours 2min',
      ),
      DailyUpdateModel(
        date: '12/04/2025',
        location: 'Dhaka, Bangladesh',
        duration: '08 Hours 2min',
      ),
    ];

    final List<ProblemsModel> problemsList = [
      ProblemsModel(
        date: '12/04/2025',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
        status: 'Pending',
        statusColorHex: AppColors.cFDA44D,
      ),
      ProblemsModel(
        date: '13/04/2025',
        description: 'Another problem description...',
        status: 'Solved',
        statusColorHex: AppColors.c22BB33, // green color
      ),
      ProblemsModel(
        date: '14/04/2025',
        description: 'Different issue faced...',
        status: 'Cancel',
        statusColorHex: AppColors.cFF4842, // blue color
      ),
    ];

    return DefaultTabController(
      length: 2, // how many inner tabs you want
      child: Column(
        children: [
          UIHelper.verticalSpace(32.h),
          TabBar(
            tabs: const [
              Tab(text: 'Daily Update'),
              Tab(text: 'Problems'),
            ],
            unselectedLabelStyle:
                TextFontStyle.headline16c919EABstylepoppinsW500,
            labelStyle: TextFontStyle.headline16cFF8E21stylepoppinsW600,
            indicatorColor: AppColors.cFF8E21,
            indicatorPadding: EdgeInsets.zero,
          ),
          UIHelper.customDivider(color: AppColors.cEBEBEB),
          Expanded(
            child: TabBarView(
              children: [
                DailyUpdateContent(updates: dailyUpdates),
                ProblemsContent(problemsList: problemsList),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
