import 'package:get/get.dart';

import '../controllers/apply_holiday_controller.dart';

class ApplyHolidayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplyHolidayController>(
      () => ApplyHolidayController(),
    );
  }
}
