// // ignore_for_file: unused_field, prefer_final_fields
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:lawbug829/assets_healper/app_image.dart';
// import 'package:lawbug829/common_widget/custom_app_bar.dart';
// import 'package:lawbug829/constants/text_font_style.dart';
// import 'package:lawbug829/features/profile/model/profile_model.dart';
// import 'package:lawbug829/gen/assets.gen.dart';
// import 'package:lawbug829/gen/colors.gen.dart';
// import 'package:lawbug829/helpers/all_routes.dart';
// import 'package:lawbug829/helpers/navigation_service.dart';
// import 'package:lawbug829/helpers/ui_helpers.dart';
// import 'package:lawbug829/networks/api_acess.dart';

// class PersonalInformationScreen extends StatefulWidget {
//   const PersonalInformationScreen({super.key});

//   @override
//   State<PersonalInformationScreen> createState() =>
//       _PersonalInformationScreen();
// }

// class _PersonalInformationScreen extends State<PersonalInformationScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

//   final _employeeIdController = TextEditingController();
//   final _fullNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmController = TextEditingController();

//   bool _isRight = false;

//   @override
//   void dispose() {
//     // dispose controllers
//     _employeeIdController.dispose();
//     _fullNameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     getProfileRXObj.profile();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: Text('Personal Information',
//             style: TextFontStyle.headline20c212B36stylepoppinsW500),
//         leading: Padding(
//           padding: EdgeInsets.only(left: 16.w),
//           child: InkWell(
//             onTap: () {
//               NavigationService.goBack;
//             },
//             child: SvgPicture.asset(
//               Assets.icons.arrowBackLawbug,
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         child: StreamBuilder<ProfileModel>(
//             stream: getProfileRXObj.getProfileRX,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 var profileData = snapshot.data!;
//                 return Column(
//                   children: [
//                     Divider(
//                       thickness: 1.w,
//                       color: AppColors.cDFE3E8,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   NavigationService.navigateToWithArgs(
//                                       Routes.editProfileScreen, {
//                                     'employeeId':
//                                         profileData.data?.employeeId ?? '',
//                                     'employeeName':
//                                         profileData.data?.name ?? '',
//                                     'employeeEmail':
//                                         profileData.data?.email ?? '',
//                                     'employeePhone':
//                                         profileData.data?.phone ?? '',
//                                     'employeeAddress':
//                                         profileData.data?.address ?? '',
//                                     'employeeGender':
//                                         profileData.data?.gender ?? '',
//                                     'employeeDob': profileData.data?.dob ?? '',
//                                   });
//                                 },
//                                 child: Image.asset(
//                                   Assets.images.rightPencil.path,
//                                   height: 24,
//                                   width: 24,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(40),
//                             child: (profileData.data?.avatar != null &&
//                                     profileData.data!.avatar!.isNotEmpty)
//                                 ? CachedNetworkImage(
//                                     imageUrl: profileData.data!.avatar!,
//                                     height: 80,
//                                     width: 80,
//                                     fit: BoxFit.cover,
//                                     placeholder: (context, url) => Image.asset(
//                                       Appimages.profileImage,
//                                       height: 80,
//                                       width: 80,
//                                       fit: BoxFit.cover,
//                                     ),
//                                     errorWidget: (context, url, error) =>
//                                         Image.asset(
//                                       Appimages.profileImage,
//                                       height: 80,
//                                       width: 80,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   )
//                                 : Image.asset(
//                                     Appimages.profileImage,
//                                     height: 80,
//                                     width: 80,
//                                     fit: BoxFit.cover,
//                                   ),
//                           ),
//                           UIHelper.verticalSpace(16.h),
//                           Align(
//                             alignment: Alignment.bottomLeft,
//                             child: Text(
//                               'Employee ID',
//                               style: TextFontStyle
//                                   .headline20c212B36stylepoppinsW500
//                                   .copyWith(fontSize: 14.sp, height: 2.57.h),
//                             ),
//                           ),
//                           UIHelper.verticalSpace(6.h),
//                           Container(
//                             height: 48,
//                             decoration: BoxDecoration(
//                               color: Colors
//                                   .transparent, // optional, set your desired background color
//                               border: Border.all(
//                                 color: Color(0xFFFFDCBA), // hex for #FFDCBA
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               children: [
//                                 UIHelper.horizontalSpace(10.w),
//                                 Text(
//                                   profileData.data?.employeeId ?? "Employee ID",
//                                   style: TextFontStyle.text15cFFF2C2.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 15,
//                                       color: AppColors.c454F5B),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.bottomLeft,
//                             child: Text(
//                               'Full Name',
//                               style: TextFontStyle
//                                   .headline20c212B36stylepoppinsW500
//                                   .copyWith(fontSize: 14.sp, height: 2.57.h),
//                             ),
//                           ),
//                           UIHelper.verticalSpace(6.h),
//                           Container(
//                             height: 48,
//                             decoration: BoxDecoration(
//                               color: Colors
//                                   .transparent, // optional, set your desired background color
//                               border: Border.all(
//                                 color: Color(0xFFFFDCBA), // hex for #FFDCBA
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               children: [
//                                 UIHelper.horizontalSpace(10.w),
//                                 Text(
//                                   profileData.data?.name ?? "User Name",
//                                   style: TextFontStyle.text15cFFF2C2.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 15,
//                                       color: AppColors.c454F5B),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.bottomLeft,
//                             child: Text(
//                               'Date of Birth',
//                               style: TextFontStyle
//                                   .headline20c212B36stylepoppinsW500
//                                   .copyWith(fontSize: 14.sp, height: 2.57.h),
//                             ),
//                           ),
//                           UIHelper.verticalSpace(6.h),
//                           Container(
//                             height: 48,
//                             decoration: BoxDecoration(
//                               color: Colors
//                                   .transparent, // optional, set your desired background color
//                               border: Border.all(
//                                 color: Color(0xFFFFDCBA), // hex for #FFDCBA
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               children: [
//                                 UIHelper.horizontalSpace(10.w),
//                                 Text(
//                                   profileData.data?.dob ?? "Date of Birth",
//                                   style: TextFontStyle.text15cFFF2C2.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 15,
//                                       color: AppColors.c454F5B),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.bottomLeft,
//                             child: Text(
//                               'Gender',
//                               style: TextFontStyle
//                                   .headline20c212B36stylepoppinsW500
//                                   .copyWith(fontSize: 14.sp, height: 2.57.h),
//                             ),
//                           ),
//                           UIHelper.verticalSpace(6.h),
//                           Container(
//                             height: 48,
//                             decoration: BoxDecoration(
//                               color: Colors
//                                   .transparent, // optional, set your desired background color
//                               border: Border.all(
//                                 color: Color(0xFFFFDCBA), // hex for #FFDCBA
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               children: [
//                                 UIHelper.horizontalSpace(10.w),
//                                 Text(
//                                   profileData.data?.gender ?? "Gender",
//                                   style: TextFontStyle.text15cFFF2C2.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 15,
//                                       color: AppColors.c454F5B),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.bottomLeft,
//                             child: Text(
//                               'Email Address',
//                               style: TextFontStyle
//                                   .headline20c212B36stylepoppinsW500
//                                   .copyWith(fontSize: 14.sp, height: 2.57.h),
//                             ),
//                           ),
//                           UIHelper.verticalSpace(6.h),
//                           Container(
//                             height: 48,
//                             decoration: BoxDecoration(
//                               color: Colors
//                                   .transparent, // optional, set your desired background color
//                               border: Border.all(
//                                 color: Color(0xFFFFDCBA), // hex for #FFDCBA
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               children: [
//                                 UIHelper.horizontalSpace(10.w),
//                                 Text(
//                                   profileData.data?.email ?? "Email Address",
//                                   style: TextFontStyle.text15cFFF2C2.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 15,
//                                       color: AppColors.c454F5B),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.bottomLeft,
//                             child: Text(
//                               'Phone number',
//                               style: TextFontStyle
//                                   .headline20c212B36stylepoppinsW500
//                                   .copyWith(fontSize: 14.sp, height: 2.57.h),
//                             ),
//                           ),
//                           UIHelper.verticalSpace(6.h),
//                           Container(
//                             height: 48,
//                             decoration: BoxDecoration(
//                               color: Colors
//                                   .transparent, // optional, set your desired background color
//                               border: Border.all(
//                                 color: Color(0xFFFFDCBA), // hex for #FFDCBA
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               children: [
//                                 UIHelper.horizontalSpace(10.w),
//                                 Text(
//                                   profileData.data?.phone ?? "Phone Number",
//                                   style: TextFontStyle.text15cFFF2C2.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 15,
//                                       color: AppColors.c454F5B),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.bottomLeft,
//                             child: Text(
//                               'Address',
//                               style: TextFontStyle
//                                   .headline20c212B36stylepoppinsW500
//                                   .copyWith(fontSize: 14.sp, height: 2.57.h),
//                             ),
//                           ),
//                           UIHelper.verticalSpace(6.h),
//                           Container(
//                             height: 48,
//                             decoration: BoxDecoration(
//                               color: Colors
//                                   .transparent, // optional, set your desired background color
//                               border: Border.all(
//                                 color: Color(0xFFFFDCBA), // hex for #FFDCBA
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               children: [
//                                 UIHelper.horizontalSpace(10.w),
//                                 Text(
//                                   profileData.data?.address ?? "Address",
//                                   style: TextFontStyle.text15cFFF2C2.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 15,
//                                       color: AppColors.c454F5B),
//                                 )
//                               ],
//                             ),
//                           ),
//                           UIHelper.verticalSpace(30.h),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             }),
//       ),
//     );
//   }
// }

// ignore_for_file: unused_field, prefer_final_fields
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawbug829/assets_healper/app_image.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/features/profile/model/profile_model.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  final _employeeIdController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isRight = false;

  // ⬇️ Boot loader flag
  bool _bootLoading = true;

  @override
  void initState() {
    super.initState();
    // trigger profile fetch
    getProfileRXObj.profile();

    // small initial loader delay
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) setState(() => _bootLoading = false);
    });
  }

  @override
  void dispose() {
    _employeeIdController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ⬇️ First-time boot loader UI
    if (_bootLoading) {
      return Scaffold(
        appBar: CustomAppBar(
          title: Text(
            'Personal Information',
            style: TextFontStyle.headline20c212B36stylepoppinsW500,
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: InkWell(
              onTap: () {
                NavigationService.goBack(); // fixed: add ()
              },
              child: SvgPicture.asset(Assets.icons.arrowBackLawbug),
            ),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // ⬇️ Normal content after boot loader
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Personal Information',
            style: TextFontStyle.headline20c212B36stylepoppinsW500),
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: InkWell(
            onTap: () {
              NavigationService.goBack(); // fixed
            },
            child: SvgPicture.asset(
              Assets.icons.arrowBackLawbug,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: StreamBuilder<ProfileModel>(
          stream: getProfileRXObj.getProfileRX,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final profileData = snapshot.data!;
              return Column(
                children: [
                  Divider(
                    thickness: 1.w,
                    color: AppColors.cDFE3E8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                NavigationService.navigateToWithArgs(
                                  Routes.editProfileScreen,
                                  {
                                    'employeeId':
                                        profileData.data?.employeeId ?? '',
                                    'employeeName':
                                        profileData.data?.name ?? '',
                                    'employeeEmail':
                                        profileData.data?.email ?? '',
                                    'employeePhone':
                                        profileData.data?.phone ?? '',
                                    'employeeAddress':
                                        profileData.data?.address ?? '',
                                    'employeeGender':
                                        profileData.data?.gender ?? '',
                                    'employeeDob': profileData.data?.dob ?? '',
                                  },
                                );
                              },
                              child: Image.asset(
                                Assets.images.rightPencil.path,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: (profileData.data?.avatar != null &&
                                  profileData.data!.avatar!.isNotEmpty)
                              ? CachedNetworkImage(
                                  imageUrl: profileData.data!.avatar!,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Image.asset(
                                    Appimages.profileImage,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    Appimages.profileImage,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(
                                  Appimages.profileImage,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        UIHelper.verticalSpace(16.h),

                        // Employee ID
                        _label('Employee ID'),
                        UIHelper.verticalSpace(6.h),
                        _readonlyBox(
                          profileData.data?.employeeId ?? "Employee ID",
                        ),

                        // Full Name
                        _label('Full Name'),
                        UIHelper.verticalSpace(6.h),
                        _readonlyBox(
                          profileData.data?.name ?? "User Name",
                        ),

                        // Date of Birth
                        _label('Date of Birth'),
                        UIHelper.verticalSpace(6.h),
                        _readonlyBox(
                          profileData.data?.dob ?? "Date of Birth",
                        ),

                        // Gender
                        _label('Gender'),
                        UIHelper.verticalSpace(6.h),
                        _readonlyBox(
                          profileData.data?.gender ?? "Gender",
                        ),

                        // Email
                        _label('Email Address'),
                        UIHelper.verticalSpace(6.h),
                        _readonlyBox(
                          profileData.data?.email ?? "Email Address",
                        ),

                        // Phone
                        _label('Phone number'),
                        UIHelper.verticalSpace(6.h),
                        _readonlyBox(
                          profileData.data?.phone ?? "Phone Number",
                        ),

                        // Address
                        _label('Address'),
                        UIHelper.verticalSpace(6.h),
                        _readonlyBox(
                          profileData.data?.address ?? "Address",
                        ),

                        UIHelper.verticalSpace(30.h),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              // while waiting for stream after boot
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Failed to load profile',
                  style: TextFontStyle.headline20c212B36stylepoppinsW500
                      .copyWith(fontSize: 14, color: AppColors.c637381),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  // ----- Small helpers -----
  Widget _label(String text) => Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          text,
          style: TextFontStyle.headline20c212B36stylepoppinsW500
              .copyWith(fontSize: 14.sp, height: 2.57.h),
        ),
      );

  Widget _readonlyBox(String value) => Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: const Color(0xFFFFDCBA),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            UIHelper.horizontalSpace(10.w),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextFontStyle.text15cFFF2C2.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppColors.c454F5B,
                ),
              ),
            ),
          ],
        ),
      );
}
