import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeScreenController extends GetxController {
  // Selected category index
  int selectedCategoryIndex = 0;

  // Page controller for movie slider
  late PageController pageController;
  int currentPage = 0;

  /// Movie List for Slider
  final List<Map<String, String>> movies = [
    {
      "image": "https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=1000&auto=format&fit=crop",
    },
    {
      "image": "https://www.fortressofsolitude.co.za/wp-content/uploads/2024/09/Take-Cover-Scott-Adkins-2024-Movie-Review.jpg",
    },
    {
      "image": "https://photoble.com/wp-content/uploads/2010/10/one_pesron_long2_S.jpg",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiCZatshqKfhmYUoYLvbj3s9hh5slUiWdkIA&s",
    },
  ];

  /// Categories List
  final List<String> categories = [
    'All',
    'Action',
    'Anime',
    'Sci-fi',
    'Thriller',
  ];

  /// Trending Movies List
  final List<Map<String, String>> trendingMovies = [
    {
      "image": "https://marketplace.canva.com/EAFTl0ixW_k/1/0/1131w/canva-black-white-minimal-alone-movie-poster-YZ-0GJ13Nc8.jpg",
      "title": "Walk Alone"
    },
    {
      "image": "https://images.moviesanywhere.com/6305a9e8ed76d5fa485ac16637655cf7/bcc68be4-eede-409b-a63d-e179b28d19b4.jpg",
      "title": "Cover"
    },
    {
      "image":
          "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/movie-poster-template-design-21a1c803fe4ff4b858de24f5c91ec57f_screen.jpg?ts=1636996180",
      "title": "After",
    },
    {
      "image": "https://image.tmdb.org/t/p/w500/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
      "title": "Dune: Part Two",
    },
    {
      "image": "https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
      "title": "Avengers: Infinity War",
    },
    {
      "image":
          "https://media.glamour.com/photos/56957ec78fa134644ec24e88/master/w_1600%2Cc_limit/entertainment-2014-06-the-giver-movie-poster-main.jpg",
      "title": "Glamour",
    },
    {
      "image": "https://image.tmdb.org/t/p/w500/A4j8S6moJS2zNtRR8oWF08gRnL5.jpg",
      "title": "The Batman",
    },
  ];

  /// Continue Watching List
  final List<Map<String, String>> continueWatching = [
    {
      "image": "https://i.pinimg.com/originals/0b/b1/2c/0bb12cbdf3673531c6d1d4c5a0a11853.jpg",
      "title": "Iron Man",
      "episode": "Season - 1 Episode - 1",
    },
    {
      "image": "https://i.ebayimg.com/images/g/xakAAOSwtUtlKr2E/s-l400.jpg",
      "title": "Smile",
      "episode": "Season - 2 Episode - 5",
    },
  ];

  /// Recommended Movies List
  final List<Map<String, String>> recommendedMovies = [
    {
      "image":
          "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/adventure-movie-poster-template-design-7b13ea2ab6f64c1ec9e1bb473f345547_screen.jpg?ts=1636999411",
      "title": "Archer",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrUQ3tB_Z5X6rfehzKWVC9udWYYklUJS2DPw&s",
      "title": "Harry Potter",
    },
    {
      "image":
          "https://m.media-amazon.com/images/M/MV5BNDZjNTZkMGEtYjM4ZC00OWU1LThmZmUtMjNhMWM4Njg4YmRhXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
      "title": "Take Cover",
    },
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    startAutoSlide();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // Auto slide timer
  void startAutoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (currentPage < movies.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      if (pageController.hasClients) {
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
      startAutoSlide();
    });
  }

  // Method to change category
  void changeCategory(int index) {
    selectedCategoryIndex = index;
    update();
  }

  // Method to handle page change
  void onPageChanged(int page) {
    currentPage = page;
    update();
  }
}
