import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bd_calling_task/utils/app_colors.dart';
import 'custom_shimmer.dart';

class ContinueWatchingItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String episode;

  const ContinueWatchingItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      margin: EdgeInsets.only(right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 120.h,
                  width: 200.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CustomShimmer(
                    height: 120.h,
                    width: 200.w,
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 120.h,
                    width: 200.w,
                    color: Colors.grey.withOpacity(0.1),
                    child: Icon(
                      Icons.error_outline,
                      color: AppColors.grey,
                      size: 40.sp,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 4.h,
                    color: Colors.grey.withOpacity(0.3),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                        const Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            episode,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
} 