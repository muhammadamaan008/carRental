import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Color backgroundColor;
  final Color? foregroundColor;
  final bool backArrow;
  const CustomAppBar(
      {super.key,
      required this.title,
      required this.centerTitle,
       this.backArrow = true,
      required this.backgroundColor,
      this.foregroundColor});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17.sp),),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      centerTitle: centerTitle,
      automaticallyImplyLeading: backArrow,
    );
  }
}
