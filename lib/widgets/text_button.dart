import 'package:flutter/material.dart';
import 'package:rental_app/utils/constants.dart';
import 'package:sizer/sizer.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String btnText;
  final bool loading;
  const CustomTextButton({super.key, this.onPressed, required this.btnText, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all( AppConstants.mainColor)),
      child: loading ?  CircularProgressIndicator(color: Colors.black,strokeWidth: 2.sp): Text(
        btnText.toString(),
        style: TextStyle(
            color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}
