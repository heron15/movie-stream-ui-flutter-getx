import 'package:bd_calling_task/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/dependency/dependency.dart';
import 'core/route/app_route.dart';
import 'core/theme/app_theme.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

class MovieStreamApp extends StatefulWidget {
  const MovieStreamApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MovieStreamApp> createState() => _MovieStreamAppState();
}

class _MovieStreamAppState extends State<MovieStreamApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return GetMaterialApp(
          navigatorKey: MovieStreamApp.navigatorKey,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
          initialRoute: AppRoute.bottomNavBarScreen,
          getPages: AppRoute.route,
          initialBinding: Dependency(),
          theme: getAppTheme(),
          navigatorObservers: [routeObserver],
        );
      },
    );
  }
}
