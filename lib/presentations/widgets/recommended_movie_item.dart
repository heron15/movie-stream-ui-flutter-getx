import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bd_calling_task/utils/app_colors.dart';
import 'custom_shimmer.dart';

class RecommendedMovieItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  const RecommendedMovieItem({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.w),
      width: 140.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 180.h,
              width: 140.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => CustomShimmer(
                height: 180.h,
                width: 140.w,
              ),
              errorWidget: (context, url, error) => Container(
                height: 180.h,
                width: 140.w,
                color: Colors.grey.withOpacity(0.1),
                child: Icon(
                  Icons.error_outline,
                  color: AppColors.grey,
                  size: 40.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
} 