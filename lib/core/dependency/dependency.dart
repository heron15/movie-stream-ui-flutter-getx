import 'package:bd_calling_task/data/services/network_caller.dart';
import 'package:bd_calling_task/presentations/screens/bottom_nav_bar/controller/bottom_nav_bar_screen_controller.dart';
import 'package:bd_calling_task/presentations/screens/downloads/controller/downloads_screen_controller.dart';
import 'package:bd_calling_task/presentations/screens/home/controller/home_screen_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class Dependency extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Logger(), fenix: true);
    Get.lazyPut(() => NetworkCaller(logger: Get.find<Logger>()), fenix: true);

    Get.lazyPut(() => HomeScreenController(), fenix: true);
    Get.lazyPut(() => BottomNavBarScreenController(), fenix: true);
    Get.lazyPut(() => DownloadsScreenController(), fenix: true);
  }
}
