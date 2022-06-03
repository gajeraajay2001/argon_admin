import 'package:get/get.dart';

import '../../main.dart';
import '../constants/api_constant.dart';
import '../modules/all_user_list/bindings/all_user_list_binding.dart';
import '../modules/all_user_list/views/all_user_list_view.dart';
import '../modules/create_user_screen/bindings/create_user_screen_binding.dart';
import '../modules/create_user_screen/views/create_user_screen_view.dart';
import '../modules/dashboard_screen/bindings/dashboard_screen_binding.dart';
import '../modules/dashboard_screen/views/dashboard_screen_view.dart';
import '../modules/detail_screen/bindings/detail_screen_binding.dart';
import '../modules/detail_screen/views/detail_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/leave_screen/bindings/leave_screen_binding.dart';
import '../modules/leave_screen/views/leave_screen_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static String INITIAL = (box.read(ArgumentConstant.isUserLogin) == null)
      ? Routes.LOGIN_PAGE
      : Routes.DASHBOARD_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_USER_SCREEN,
      page: () => CreateUserScreenView(),
      binding: CreateUserScreenBinding(),
    ),
    GetPage(
      name: _Paths.ALL_USER_LIST,
      page: () => AllUserListView(),
      binding: AllUserListBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SCREEN,
      page: () => DetailScreenView(),
      binding: DetailScreenBinding(),
    ),
    GetPage(
      name: _Paths.LEAVE_SCREEN,
      page: () => LeaveScreenView(),
      binding: LeaveScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_SCREEN,
      page: () => DashboardScreenView(),
      binding: DashboardScreenBinding(),
    ),
  ];
}
