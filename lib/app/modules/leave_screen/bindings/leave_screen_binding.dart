import 'package:get/get.dart';

import '../controllers/leave_screen_controller.dart';

class LeaveScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveScreenController>(
      () => LeaveScreenController(),
    );
  }
}
