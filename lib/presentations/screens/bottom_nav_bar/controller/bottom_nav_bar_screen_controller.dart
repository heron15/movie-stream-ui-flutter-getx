import 'package:get/get.dart';

class BottomNavBarScreenController extends GetxController {
  int selectedIndex = 0;

  void changeIndex(int index) {
    selectedIndex = index;
    update();
  }
}
