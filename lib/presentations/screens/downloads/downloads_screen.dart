import 'package:bd_calling_task/data/models/post_model.dart';
import 'package:bd_calling_task/presentations/screens/downloads/controller/downloads_screen_controller.dart';
import 'package:bd_calling_task/presentations/widgets/custom_shimmer.dart';
import 'package:bd_calling_task/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({super.key});

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  // Header section
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Downloads",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          GetBuilder<DownloadsScreenController>(
            builder: (controller) {
              if (controller.isOffline) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.offline_bolt_rounded,
                        color: Colors.orange,
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "Offline Mode",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  // Main body with refresh indicator
  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        Get.find<DownloadsScreenController>().getPosts();
      },
      child: GetBuilder<DownloadsScreenController>(
        builder: (controller) {
          if (controller.isLoading) {
            return _buildLoadingList();
          }

          if (controller.error.isNotEmpty) {
            return _buildErrorView(controller.error);
          }

          return _buildPostList(controller);
        },
      ),
    );
  }

  // Error view
  Widget _buildErrorView(String error) {
    return Center(
      child: Text(
        error,
        style: TextStyle(
          color: Colors.red,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  // Post list view
  Widget _buildPostList(DownloadsScreenController controller) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: controller.posts.length,
      itemBuilder: (context, index) {
        final post = controller.posts[index];
        return _buildPostItem(post);
      },
    );
  }

  // Single post item
  Widget _buildPostItem(PostModel post) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 24, 28, 34),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostHeader(post),
          SizedBox(height: 12.h),
          _buildPostBody(post),
        ],
      ),
    );
  }

  // Post header with user avatar and title
  Widget _buildPostHeader(PostModel post) {
    return Row(
      children: [
        _buildUserAvatar(post),
        SizedBox(width: 12.w),
        _buildPostTitle(post),
        _buildDownloadIcon(),
      ],
    );
  }

  // User avatar circle
  Widget _buildUserAvatar(PostModel post) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: Colors.primaries[post.id % Colors.primaries.length],
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '${post.userId}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Post title
  Widget _buildPostTitle(PostModel post) {
    return Expanded(
      child: Text(
        post.title,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // Download icon button
  Widget _buildDownloadIcon() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.download_done_rounded,
        color: Colors.green,
        size: 24.sp,
      ),
    );
  }

  // Post body text
  Widget _buildPostBody(PostModel post) {
    return Text(
      post.body,
      style: TextStyle(
        color: AppColors.grey,
        fontSize: 14.sp,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Loading shimmer list
  Widget _buildLoadingList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildLoadingItem();
      },
    );
  }

  // Single loading shimmer item
  Widget _buildLoadingItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xff1C212A),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomShimmer(
                height: 40.w,
                width: 40.w,
                borderRadius: 20,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomShimmer(
                  height: 20.h,
                  width: double.infinity,
                  borderRadius: 4,
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomShimmer(
                height: 16.h,
                width: double.infinity,
                borderRadius: 4,
              ),
              SizedBox(height: 8.h),
              CustomShimmer(
                height: 16.h,
                width: 200.w,
                borderRadius: 4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
