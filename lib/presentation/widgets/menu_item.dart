import 'package:flutter/material.dart';
import 'package:swipey/utils/constants.dart';

Widget buildMenuItem(
    {required String imagePath,
    required String count,
    required double size,
    void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Image.asset(
          imagePath,
          width: size,
          height: size,
        ),
        Text(
          count,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
