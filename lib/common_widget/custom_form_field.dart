// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:lawbug829/gen/colors.gen.dart';

// class CustomTextField extends StatefulWidget {
//   final String hintText;
//   final String? prefixIcon;
//   final TextEditingController controller;
//   final bool isPassword;
//   final String? Function(String?)? validator;

//   const CustomTextField({
//     super.key,
//     required this.hintText,
//      this.prefixIcon,
//     required this.controller,
//     this.isPassword = false,
//     this.validator,
//   });

//   @override
//   // ignore: library_private_types_in_public_api
//   _CustomTextFieldState createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   bool _obscureText = true;
//   bool _isFocused = false;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         FocusScope(
//           child: Focus(
//             onFocusChange: (focus) {
//               setState(() {
//                 _isFocused = focus;
//               });
//             },
//             child: TextFormField(
//               controller: widget.controller,
//               obscureText: widget.isPassword ? _obscureText : false,
//               validator: widget.validator,
//               decoration: InputDecoration(
//                 hintText: widget.hintText,
//                 hintStyle: TextStyle(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.cA3A3A3,
//                 ),
//                 prefixIcon: Padding(
//                   padding:
//                       EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
//                   child: SvgPicture.asset(widget.prefixIcon),
//                 ),
//                 suffixIcon: widget.isPassword
//                     ? IconButton(
//                         icon: Icon(
//                           _obscureText
//                               ? Icons.visibility_off
//                               : Icons.visibility,
//                           color: AppColors.cA3A3A3,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscureText = !_obscureText;
//                           });
//                         },
//                       )
//                     : null,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color: AppColors.cDFE1E6,
//                     width: 1.w,
//                   ),
//                 ),

//                 errorStyle: TextStyle(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.red, // Change to your desired color
//                 ),

//                 // **Set error border color**
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color:
//                         Colors.red, // Change to your desired error border color
//                     width: 1.w,
//                   ),
//                 ),

//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color:
//                         Colors.red, // Change to your desired error border color
//                     width: 1.w,
//                   ),
//                 ),

//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(
//                     color: AppColors.cE69F6C,
//                   ),
//                 ),
//                 fillColor: _isFocused ? AppColors.cFFF1E7 : Colors.white,
//                 filled: true,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
