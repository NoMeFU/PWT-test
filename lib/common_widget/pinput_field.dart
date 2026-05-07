// common_widget/pinput_field.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:pinput/pinput.dart';

class PinputField extends StatefulWidget {
  const PinputField({Key? key}) : super(key: key);

  @override
  State<PinputField> createState() => _PinputFieldState();
}

class _PinputFieldState extends State<PinputField> {
  
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.cFF8E21;
    const fillColor = AppColors.cFFFFFF;
    const borderColor = AppColors.c212B36;

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.cFF8E21
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: borderColor),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Pinput(
            length: 6,
            controller: _pinController,
            focusNode: _focusNode,
            defaultPinTheme: defaultPinTheme,
            separatorBuilder: (_) => const SizedBox(width: 8),
            // validator: (value) =>
            //     value == '222222' ? null : 'Code is incorrect',
            onCompleted: (pin) => debugPrint('Completed: $pin'),
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  width: 20,
                  height: 2,
                  color: focusedBorderColor,
                ),
              ],
            ),
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: focusedBorderColor),
              ),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: fillColor,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: focusedBorderColor),
              ),
            ),
            // errorPinTheme: defaultPinTheme.copyBorderWith(
            //   border: Border.all(color: Colors.redAccent),
            // ),
          ),
          const SizedBox(height: 16),
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       _focusNode.unfocus();
          //       if (_formKey.currentState!.validate()) {
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(content: Text('Code is correct!')),
          //         );
          //       }
          //     },
          //     child: const Text('Verify'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
