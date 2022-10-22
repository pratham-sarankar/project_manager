import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/models/project.dart';
import 'package:project_manager/app/data/repositories/project_repository.dart';

class ProjectDetailsController extends GetxController {
  late GlobalKey<FormState> formKey;
  late Project project;
  late String projectId;
  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    project = Project.fromMap(Get.arguments['project']);
    projectId = Get.arguments['projectId'];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> updateProject() async {
    formKey.currentState?.save();
    await ProjectRepository.instance.updateById(project, projectId);
    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
