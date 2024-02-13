import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
  final String? labelText;
  final bool? enable;

  const CustomTextFormField(
      {super.key,
      this.fieldController,
      this.isTextObscured = false,
      this.cursorColor,
      this.enable = true,
      this.prefixIcon,
      this.prefixIconColor,
      required this.onValidate,
      this.hintText,
      this.hintTextColor,
      this.suffixIcon,
      this.textColor,
      this.underlineColor,
      this.suffixIconColor,
      this.labelText,
      this.isFocused = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      cursorColor: cursorColor,
      enabled: enable,
      obscureText: isTextObscured,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
          prefix: prefixIcon != null
              ? IconTheme(
                  data: const IconThemeData(
                    color: Colors.grey,
                  ),
                  child: prefixIcon!,
                )
              : null,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
              color: Colors.grey.shade400, fontSize: 13.sp, height: -0.5.sp),
          hintStyle: TextStyle(color: hintTextColor),
          prefixIconColor: prefixIconColor,
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: underlineColor ?? Colors.white),
          ),
           disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: underlineColor ?? Colors.white),
          )
          
          ),
          
      validator: onValidate,
    );
  }
}
