import 'package:bd_calling_task/presentations/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:bd_calling_task/presentations/screens/home/home_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static const String bottomNavBarScreen = "/bottom_nav_bar_screen";
  static const String homeScreen = "/home_screen";

  static List<GetPage> route = [
    GetPage(name: bottomNavBarScreen, page: () => const BottomNavBarScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
  ];
}
