import 'package:get/get.dart';

import '../controllers/create_user_screen_controller.dart';

class CreateUserScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUserScreenController>(
      () => CreateUserScreenController(),
    );
  }
}
