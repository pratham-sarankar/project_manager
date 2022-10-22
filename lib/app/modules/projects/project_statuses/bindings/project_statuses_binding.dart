import 'package:get/get.dart';

import '../controllers/project_statuses_controller.dart';

class ProjectStatusesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectStatusesController>(
      () => ProjectStatusesController(),
    );
  }
}
