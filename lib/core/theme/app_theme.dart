import 'package:bd_calling_task/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData getAppTheme() => ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        shadowColor: Colors.black,
        elevation: 1,
        surfaceTintColor: AppColors.white,
        iconTheme: IconThemeData(
          color: AppColors.white,
          size: 24.sp,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          fixedSize: const Size.fromWidth(double.maxFinite),
          padding: EdgeInsets.symmetric(vertical: 15.h),
          textStyle: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
      ),
    );
