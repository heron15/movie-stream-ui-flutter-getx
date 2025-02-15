import 'package:bd_calling_task/presentations/screens/bottom_nav_bar/controller/bottom_nav_bar_screen_controller.dart';
import 'package:bd_calling_task/presentations/screens/downloads/downloads_screen.dart';
import 'package:bd_calling_task/presentations/screens/home/home_screen.dart';
import 'package:bd_calling_task/presentations/screens/playlist/playlist_screen.dart';
import 'package:bd_calling_task/presentations/screens/profile/profile_screen.dart';
import 'package:bd_calling_task/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final controller = Get.put(BottomNavBarScreenController());

  final List<Widget> screens = [
    const HomeScreen(),
    const DownloadsScreen(),
    const PlaylistScreen(),
    const ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<BottomNavBarScreenController>(
          builder: (controller) {
            return IndexedStack(
              index: controller.selectedIndex,
              children: screens,
            );
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: GetBuilder<BottomNavBarScreenController>(
            builder: (controller) {
              return SafeArea(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.only(
                    left: 24.w,
                    right: 24.w,
                    bottom: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.bottomNavBgColor,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(Icons.home_rounded, 0),
                      _buildNavItem(Icons.download_rounded, 1),
                      _buildNavItem(Icons.playlist_play_rounded, 2),
                      _buildNavItem(Icons.person_rounded, 3),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GetBuilder<BottomNavBarScreenController>(
      builder: (controller) {
        final isSelected = controller.selectedIndex == index;
        return GestureDetector(
          onTap: () => controller.changeIndex(index),
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 28.sp,
              color: isSelected ? Colors.red : AppColors.grey,
            ),
          ),
        );
      },
    );
  }
}
