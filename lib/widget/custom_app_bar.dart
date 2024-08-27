//Created by MansoorSatti 8/27/2024
//Created by MansoorSatti 8/7/2024
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.bottom,
    this.height = 56,
  });

  final Widget title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AppBar(
        backgroundColor: Colors.white,
        title: title,
        // style: heading1.copyWith(color: AppColors.white),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        centerTitle: true,
        actions: actions,
        bottom: bottom,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  Size.fromHeight(height);
}
