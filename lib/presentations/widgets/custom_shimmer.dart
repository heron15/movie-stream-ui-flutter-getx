import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bd_calling_task/utils/app_colors.dart';

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const CustomShimmer({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.simmerBgColor,
      highlightColor: AppColors.simmerItemColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
    );
  }
}
