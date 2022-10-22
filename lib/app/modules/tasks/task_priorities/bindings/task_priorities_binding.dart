import 'package:get/get.dart';

import '../controllers/task_priorities_controller.dart';

class TaskPrioritiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskPrioritiesController>(
      () => TaskPrioritiesController(),
    );
  }
}
