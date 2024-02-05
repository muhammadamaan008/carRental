import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController fieldController;
  final bool isTextObscured;
  final Color cursorColor;
  final Widget prefixIcon;
  final Color prefixIconColor;
  final String? Function(String?) onValidate;
  final String hintText;
  final Color hintTextColor;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final Color textColor;
  final Color? underlineColor;
  final bool isFocused;

  const CustomTextFormField(
      {super.key,
      required this.fieldController,
      required this.isTextObscured,
      required this.cursorColor,
      required this.prefixIcon,
      required this.prefixIconColor,
      required this.onValidate,
      required this.hintText,
      required this.hintTextColor,
      this.suffixIcon,
      required this.textColor,
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
            data: IconThemeData(
              color: isFocused ? prefixIconColor : Colors.grey,
            ),
            child: prefixIcon,
          ),
          hintText: hintText,
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
