import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/models/task.dart';
import 'package:project_manager/app/data/repositories/task_repository.dart';

class AddTaskController extends GetxController {
  late Task task;
  late GlobalKey<FormState> formKey;
  final count = 0.obs;
  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    task = Task(projectId: Get.parameters['projectId']);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void proceed() async {
    formKey.currentState?.save();
    await TaskRepository.instance.insertOne(task);
    Get.back();
  }
}
