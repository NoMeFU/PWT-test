// #########################################################################
// ignore_for_file: unused_field, prefer_final_fields, must_be_immutable

import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:lawbug829/helpers/image_helper.dart';
import 'package:lawbug829/helpers/platform_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lawbug829/assets_healper/app_image.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/common_widget/custom_text_field.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lottie/lottie.dart';

class EditProfileScreen extends StatefulWidget {
  dynamic employeeId,
      employeeName,
      employeeEmail,
      employeeDob,
      employeeGender,
      employeePhone,
      employeeAddress;
  EditProfileScreen({
    super.key,
    this.employeeId,
    this.employeeName,
    this.employeeEmail,
    this.employeeDob,
    this.employeeGender,
    this.employeePhone,
    this.employeeAddress,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    getProfileRXObj.profile();
    _employeeIdController.text = widget.employeeId ?? '';
    _fullNameController.text = widget.employeeName ?? '';
    _emailController.text = widget.employeeEmail ?? '';
    _dobController.text = widget.employeeDob ?? '';
    _genderController.text = widget.employeeGender ?? '';
    _phoneController.text = widget.employeePhone ?? '';
    _addressController.text = widget.employeeAddress ?? '';
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).unfocus(); // Hide keyboard
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      _dobController.text =
          "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
    }
  }

  // * Controllers
  final _employeeIdController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  // * Country Code
  String _selectedCountryCode = '+880'; // default or fallback

  // * Image variable
  XFile? _pickedImage;

  @override
  void dispose() {
    _employeeIdController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Personal Information',
          style: TextFontStyle.headline20c212B36stylepoppinsW500,
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: GestureDetector(
            onTap: () {
              NavigationService.goBack();
            },
            child: SvgPicture.asset(Assets.icons.arrowBackLawbug),
          ),
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: _pickedImage != null
                          ? getPlatformImageProvider(_pickedImage!.path)
                          : AssetImage(Appimages.profileImage) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          final pickedFile = await showModalBottomSheet<XFile?>(
                            context: context,
                            builder: (context) => SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text('Gallery'),
                                    onTap: () async {
                                      final picker = ImagePicker();
                                      final picked = await picker.pickImage(
                                          source: ImageSource.gallery);
                                      Navigator.pop(context, picked);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text('Camera'),
                                    onTap: () async {
                                      final picker = ImagePicker();
                                      final picked = await picker.pickImage(
                                          source: ImageSource.camera);
                                      Navigator.pop(context, picked);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );

                          if (pickedFile != null) {
                            setState(() {
                              _pickedImage = pickedFile;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 24.r,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(20.h),

              // * Employee ID
              _buildLabel("Employee ID"),
              CustomTextField(
                controller: _employeeIdController,
                hintText: 'Employee ID',
              ),

              // * Full Name
              _buildLabel("Employee Name"),
              CustomTextField(
                controller: _fullNameController,
                hintText: 'Employee Name',
              ),

              // * DOB
              _buildLabel("Employee Date of Birth"),
              CustomTextField(
                controller: _dobController,
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

              // * Gender
              _buildLabel("Employee Gender"),
              CustomTextField(
                controller: _genderController,
                hintText: 'Gender',
              ),

              // * Email
              _buildLabel("Employee Email"),
              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
              ),

              // * Phone
              _buildLabel("Employee Phone"),
              IntlPhoneField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'US',
                onChanged: (phone) {
                  setState(() {
                    _selectedCountryCode = phone.countryCode;
                  });
                },
              ),

              // * Address
              _buildLabel("Employee Address"),
              CustomTextField(
                controller: _addressController,
                hintText: 'Address',
              ),

              UIHelper.verticalSpace(20.h),
              // customeButton(
              //   name: 'Update Profile',
              //   onCallBack: () async {
              //     log("=============> Update Profile Clicked <===============");
              //     log("Employee ID: ${_employeeIdController.text}");
              //     log("Full Name: ${_fullNameController.text}");
              //     log("DOB: ${_dobController.text}");
              //     log("Gender: ${_genderController.text}");
              //     log("Email: ${_emailController.text}");
              //     log("Phone: ${_phoneController.text}");
              //     log("Address: ${_addressController.text}");
              //     log("Phone Country Code: $_selectedCountryCode");
              //     log("#######################################################");

              //     // * calling api to update profile
              //     bool isCompleted =
              //         await postEditProfileApiRXObj.postEditProfileRX(
              //       email: _emailController.text,
              //       name: _fullNameController.text,
              //       phone: _phoneController.text,
              //       address: _addressController.text,
              //       country_code: _selectedCountryCode,
              //       employee_id: _employeeIdController.text,
              //       dob: _dobController.text,
              //       gender: _genderController.text,
              //     );
              //     if (isCompleted) {
              //       log("Profile updated successfully");
              //       NavigationService.goBack;
              //     } else {
              //       log("Failed to update profile");
              //     }
              //   },
              //   context: context,
              // ),

              isLoading // If the loading state is true, show loading
                  ? Container(
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.cFFFFFF,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.cFF8E21,
                        ),
                      ),
                      child: Lottie.asset(
                        AppLottie.loading,
                        height: 100,
                        width: 100,
                      ),
                    )
                  : customeButton(
                      name: 'Update Profile',
                      onCallBack: () async {
                        setState(() {
                          isLoading = true; // Start loading
                        });
                        log("=============> Update Profile Clicked <===============");
                        log("Employee ID: ${_employeeIdController.text}");
                        log("Full Name: ${_fullNameController.text}");
                        log("DOB: ${_dobController.text}");
                        log("Gender: ${_genderController.text}");
                        log("Email: ${_emailController.text}");
                        log("Phone: ${_phoneController.text}");
                        log("Address: ${_addressController.text}");
                        log("Phone Country Code: $_selectedCountryCode");
                        log("#######################################################");

                        // Check if the profile picture is updated
                        bool isProfilePicUpdated = _pickedImage != null;

                        // If the profile picture is updated, upload it
                        if (isProfilePicUpdated) {
                          log("Updating the profile picture...");

                          bool isPicUpdated =
                              await postImageUploadRxObj.uploadImageApi(
                            avatar: _pickedImage!, // Send only the image
                          );

                          if (!isPicUpdated) {
                            log("Failed to update profile picture");
                            return; // Exit early if the image update fails
                          } else {
                            log("Profile picture updated successfully");
                          }
                        }

                        // Now update the profile information (excluding the image)
                        bool isCompleted =
                            await postEditProfileApiRXObj.postEditProfileRX(
                          email: _emailController.text,
                          name: _fullNameController.text,
                          phone: _phoneController.text,
                          address: _addressController.text,
                          country_code: _selectedCountryCode,
                          employee_id: _employeeIdController.text,
                          dob: _dobController.text,
                          gender: _genderController.text,
                        );

                        if (isCompleted) {
                          setState(() {
                            isLoading = false; // Stop loading
                          });
                          log("Profile updated successfully");
                          NavigationService.goBack();
                        } else {
                          setState(() {
                            isLoading = false; // Stop loading
                          });
                          log("Failed to update profile");
                        }
                      },
                      context: context,
                    ),

              UIHelper.verticalSpace(20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Column(
      children: [
        UIHelper.verticalSpace(15.h),
        Text(
          text,
          style: TextFontStyle.headline20c212B36stylepoppinsW500.copyWith(
            fontSize: 14.sp,
          ),
        ),
        UIHelper.verticalSpace(5.h),
      ],
    );
  }
}
