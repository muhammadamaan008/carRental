import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Color backgroundColor;
  final Color? foregroundColor;
  const CustomAppBar(
      {super.key,
      required this.title,
      required this.centerTitle,
      required this.backgroundColor,
      this.foregroundColor});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      centerTitle: centerTitle,
    );
  }
}
