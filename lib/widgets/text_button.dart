import 'package:flutter/material.dart';
import 'package:rental_app/utils/constants.dart';
import 'package:sizer/sizer.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String btnText;
  final bool loading;
  final Color backgroundColor;
  const CustomTextButton({super.key, this.onPressed, required this.btnText, this.loading = false, this.backgroundColor = AppConstants.mainColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all( backgroundColor)),
      child: loading ?  CircularProgressIndicator(color: Colors.black,strokeWidth: 2.sp): Text(
        btnText.toString(),
        style: TextStyle(
            color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}
