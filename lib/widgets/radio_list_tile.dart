import 'package:flutter/material.dart';
import 'package:rental_app/utils/constants.dart';
import 'package:sizer/sizer.dart';

class CustomRadioListTile<T extends Enum?> extends StatelessWidget {
  final T radioValue;
  final T groupValue;
  final void Function(T?) onChange;
  final String text;
  const CustomRadioListTile({super.key, required this.radioValue, required this.groupValue, required this.onChange, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(10.sp)),
      width: 40.w,
      child: RadioListTile<T>(
        contentPadding: EdgeInsets.zero,
        activeColor: AppConstants.mainColor,
        value: radioValue,
        groupValue: groupValue,
        onChanged: onChange,
        title: Text(
          text,
          style: TextStyle(fontSize: 13.sp, color: Colors.white),
        ),
      ),
    );
  }
}
