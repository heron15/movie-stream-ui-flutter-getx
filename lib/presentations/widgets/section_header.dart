import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bd_calling_task/utils/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeMoreTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        TextButton(
          onPressed: onSeeMoreTap ?? () {},
          child: Text(
            "See More",
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
} 