// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawbug829/assets_healper/app_lottie.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/common_widget/custom_dropdown_field.dart';
import 'package:lawbug829/common_widget/custom_text_field.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';
import 'package:lawbug829/networks/api_acess.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';

class AddExpenseMoneyScreen extends StatefulWidget {
  const AddExpenseMoneyScreen({super.key});

  @override
  State<AddExpenseMoneyScreen> createState() => _AddExpenseMoneyScreenState();
}

class _AddExpenseMoneyScreenState extends State<AddExpenseMoneyScreen> {
  final _amountSpentController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final descriptionController = TextEditingController();
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>(); // Added for form validation

  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).unfocus(); // Hide keyboard
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _dateController.text =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  void _openImageViewer(File imageFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Center(
                child: PhotoView(
                  imageProvider: FileImage(imageFile),
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.black),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.white, size: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? selectedOption;
  String? selectedOptionTwo;
  List<String> billOptions = ['Bills', 'Non Bills', 'Other'];
  List<String> paymentOptions = ['Credit Card', 'Debit Card', 'Other'];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Add Expense Money',
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
      body: Form(
        key: _formKey, // Wrap with Form for validation
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              UIHelper.customDivider(color: AppColors.cDFE3E8),
              UIHelper.verticalSpace(16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Amount Spent',
                        style: TextFontStyle.headline20c212B36stylepoppinsW500
                            .copyWith(fontSize: 14.sp, height: 2.57.h),
                      ),
                    ),
                    UIHelper.verticalSpace(6.h),
                    CustomTextField(
                      controller: _amountSpentController,
                      hintText: 'Enter Amount Spent',
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Amount Spent is required';
                        }
                        if (double.tryParse(v) == null) {
                          return 'Enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    UIHelper.verticalSpace(4.h),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Date of Expense',
                        style: TextFontStyle.headline20c212B36stylepoppinsW500
                            .copyWith(fontSize: 14.sp, height: 2.57.h),
                      ),
                    ),
                    UIHelper.verticalSpace(6.h),
                    CustomTextField(
                      controller: _dateController,
                      hintText: 'Enter Date of Expense',
                      suffixIcon: Assets.icons.calenderLawbug,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Date of Expense is required';
                        }
                        return null;
                      },
                    ),
                    UIHelper.verticalSpace(4.h),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Expense Category',
                        style: TextFontStyle.headline20c212B36stylepoppinsW500
                            .copyWith(fontSize: 14.sp, height: 2.57.h),
                      ),
                    ),
                    UIHelper.verticalSpace(6.h),
                    CustomDropdownField(
                      value: selectedOption,
                      onChanged: (val) => setState(() => selectedOption = val),
                      items: billOptions,
                      hintText: "Select bill type",
                      suffixIcon: Assets.icons.dropDownLawbug,
                      validator: (v) {
                        if (v == null) {
                          return 'Expense Category is required';
                        }
                        return null;
                      },
                    ),
                    UIHelper.verticalSpace(4.h),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Payment Method',
                        style: TextFontStyle.headline20c212B36stylepoppinsW500
                            .copyWith(fontSize: 14.sp, height: 2.57.h),
                      ),
                    ),
                    UIHelper.verticalSpace(6.h),
                    CustomDropdownField(
                      value: selectedOptionTwo,
                      onChanged: (val) =>
                          setState(() => selectedOptionTwo = val),
                      items: paymentOptions,
                      hintText: "Select Payment type",
                      suffixIcon: Assets.icons.dropDownLawbug,
                      validator: (v) {
                        if (v == null) {
                          return 'Payment Method is required';
                        }
                        return null;
                      },
                    ),
                    UIHelper.verticalSpace(4.h),
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
                          return 'Location is required';
                        }
                        return null;
                      },
                    ),
                    UIHelper.verticalSpace(16.h),
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
                          'Notes or Description',
                          style: TextFontStyle.headline16c212B36stylepoppinsW600
                              .copyWith(height: 1.5.h),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(16.h),
                    TextFormField(
                      controller: descriptionController,
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
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Description is required';
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
                          'Attach Receipt',
                          style: TextFontStyle.headline16c212B36stylepoppinsW600
                              .copyWith(height: 1.5.h),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(16.h),
                    GestureDetector(
                      onTap: _pickedImage == null ? _pickImage : null,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.cFFF4E9,
                          border: Border.all(color: AppColors.cFF8E21),
                        ),
                        child: _pickedImage == null
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(Assets.icons.cloudPlus),
                                  UIHelper.verticalSpace(8.h),
                                  Text(
                                    'Image upload',
                                    style: TextFontStyle
                                        .headline14c919EABstylepoppinsW400,
                                  ),
                                ],
                              )
                            : Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        _openImageViewer(_pickedImage!),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.file(
                                        _pickedImage!,
                                        width: double.infinity,
                                        height: 200.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: _removeImage,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.c919EAB,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.close,
                                            color: Colors.white, size: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    UIHelper.verticalSpace(36.h),
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
                            context: context,
                            onCallBack: () async {
                              setState(() {
                                isLoading = true; // Start loading
                              });
                              if (_formKey.currentState!.validate()) {
                                if (kDebugMode) {
                                  log('Amount Spent: ${_amountSpentController.text}');
                                  log('Date: ${_dateController.text}');
                                  log('Category: $selectedOption');
                                  log('Payment Method: $selectedOptionTwo');
                                  log('Location: ${_locationController.text}');
                                  log('Description: ${descriptionController.text}');
                                  log('Picked Image: ${_pickedImage?.path}');
                                }

                                try {
                                  // * Call the API with corrected parameters
                                  final response =
                                      await postExpenseApiRXObj.postExpenseRX(
                                    amount_spent: _amountSpentController.text,
                                    date: _dateController.text,
                                    category: selectedOption!,
                                    payment_method: selectedOptionTwo!,
                                    location: _locationController.text,
                                    description: descriptionController.text,
                                    file: _pickedImage, // Pass File? object
                                  );

                                  ToastUtil.showLongToast(
                                      'Expense submitted successfully');
                                  NavigationService.goBack();
                                } catch (e) {
                                  ToastUtil.showLongToast(
                                      'Failed to submit expense: $e');
                                }
                              }
                            },
                          ),
                    UIHelper.verticalSpace(15.h),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
