import 'package:get/get.dart';

import '../controllers/all_user_list_controller.dart';

class AllUserListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllUserListController>(
      () => AllUserListController(),
    );
  }
}
