import 'package:bd_calling_task/presentations/screens/home/controller/home_screen_controller.dart';
import 'package:bd_calling_task/presentations/widgets/custom_shimmer.dart';
import 'package:bd_calling_task/utils/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:bd_calling_task/presentations/widgets/trending_movie_item.dart';
import 'package:bd_calling_task/presentations/widgets/continue_watching_item.dart';
import 'package:bd_calling_task/presentations/widgets/section_header.dart';
import 'package:bd_calling_task/presentations/widgets/recommended_movie_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 15.h),
                _buildSearchBar(),
                SizedBox(height: 10.h),
                _buildCategoriesSection(),
                SizedBox(height: 20.h),
                _buildMovieCard(),
                SizedBox(height: 15.h),
                _buildTrendingMovies(),
                SizedBox(height: 5.h),
                _buildContinueWatching(),
                SizedBox(height: 10.h),
                _buildRecommendedMovies(),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header section with profile
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello Rafsan",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            Text(
              "Let's watch today",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: CachedNetworkImage(
            imageUrl: "https://i.pravatar.cc/100",
            width: 40.w,
            height: 40.w,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ],
    );
  }

  // Search bar widget
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: AppColors.grey,
                  size: 24.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: AppColors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.tune,
            color: AppColors.grey,
            size: 24.sp,
          ),
        ),
      ],
    );
  }

  // Categories section
  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Categories",
          onSeeMoreTap: () {
            // Add categories see more functionality
          },
        ),
        SizedBox(height: 10.h),
        GetBuilder<HomeScreenController>(
          builder: (controller) {
            return SizedBox(
              height: 35.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => controller.changeCategory(index),
                    child: Container(
                      margin: EdgeInsets.only(right: 12.w),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: controller.selectedCategoryIndex == index ? Colors.red : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        controller.categories[index],
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  // Movie card widget
  Widget _buildMovieCard() {
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return Column(
          children: [
            SizedBox(
              height: 140.h,
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.movies.length,
                itemBuilder: (context, index) {
                  final movie = controller.movies[index];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: CachedNetworkImage(
                        imageUrl: movie["image"]!,
                        height: 140.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => CustomShimmer(
                          height: 140.h,
                          width: double.infinity,
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 140.h,
                          width: double.infinity,
                          color: Colors.grey.withOpacity(0.1),
                          child: Icon(
                            Icons.error_outline,
                            color: AppColors.grey,
                            size: 40.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            // Dot indicators
            SmoothPageIndicator(
              controller: controller.pageController,
              count: controller.movies.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8.w,
                dotWidth: 8.w,
                activeDotColor: Colors.red,
                dotColor: Colors.grey.withOpacity(0.5),
                spacing: 8.w,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTrendingMovies() {
    return Column(
      children: [
        SectionHeader(
          title: "Trending Movies",
          onSeeMoreTap: () {},
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 200.h,
          child: GetBuilder<HomeScreenController>(
            builder: (controller) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.trendingMovies.length,
                itemBuilder: (context, index) {
                  final movie = controller.trendingMovies[index];
                  return TrendingMovieItem(
                    imageUrl: movie["image"]!,
                    title: movie["title"]!,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContinueWatching() {
    return Column(
      children: [
        SectionHeader(
          title: "Continue Watching",
          onSeeMoreTap: () {},
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 180.h,
          child: GetBuilder<HomeScreenController>(
            builder: (controller) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.continueWatching.length,
                itemBuilder: (context, index) {
                  final item = controller.continueWatching[index];
                  return ContinueWatchingItem(
                    imageUrl: item["image"]!,
                    title: item["title"]!,
                    episode: item["episode"]!,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedMovies() {
    return Column(
      children: [
        SectionHeader(
          title: "Recommended For You",
          onSeeMoreTap: () {},
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 220.h,
          child: GetBuilder<HomeScreenController>(
            builder: (controller) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.recommendedMovies.length,
                itemBuilder: (context, index) {
                  final movie = controller.recommendedMovies[index];
                  return RecommendedMovieItem(
                    imageUrl: movie["image"]!,
                    title: movie["title"]!,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
