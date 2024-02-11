import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? fieldController;
  final bool isTextObscured;
  final Color? cursorColor;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final String? Function(String?) onValidate;
  final String? hintText;
  final Color? hintTextColor;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final Color? textColor;
  final Color? underlineColor;
  final bool? isFocused;

  const CustomTextFormField(
      {super.key,
      this.fieldController,
      this.isTextObscured = false,
      this.cursorColor,
      this.prefixIcon,
      this.prefixIconColor,
      required this.onValidate,
      this.hintText,
      this.hintTextColor,
      this.suffixIcon,
      this.textColor,
      this.underlineColor,
      this.suffixIconColor,
      this.isFocused = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      cursorColor: cursorColor,
      obscureText: isTextObscured,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
          prefixIcon: IconTheme(
            data: const IconThemeData(
              color: Colors.grey,
            ),
            child: prefixIcon ?? const SizedBox(),
          ),
          hintText: hintText,
          // labelText: 'Enter Name',
          // labelStyle: TextStyle(
          //   color: AppConstants.mainColor,
          //   fontSize: 15.sp,
          //   height: -0.5.sp
          // ),
          hintStyle: TextStyle(color: hintTextColor),
          prefixIconColor: prefixIconColor,
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: underlineColor ?? Colors.white),
          )),
      validator: onValidate,
    );
  }
}
