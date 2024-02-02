import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String btnText;
  const CustomTextButton({super.key, this.onPressed, required this.btnText});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF46f598))),
      child: Text(
        btnText.toString(),
        style: TextStyle(
            color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}
