import 'package:get/get.dart';

import '../controllers/task_status_controller.dart';

class TaskStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskStatusController>(
      () => TaskStatusController(),
    );
  }
}
