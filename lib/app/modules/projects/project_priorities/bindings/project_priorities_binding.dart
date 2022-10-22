import 'package:get/get.dart';

import '../controllers/project_priorities_controller.dart';

class ProjectPrioritiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectPrioritiesController>(
      () => ProjectPrioritiesController(),
    );
  }
}
