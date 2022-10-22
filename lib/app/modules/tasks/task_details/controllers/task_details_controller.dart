import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/models/task.dart';
import 'package:project_manager/app/data/repositories/task_repository.dart';

class TaskDetailsController extends GetxController {
  late GlobalKey<FormState> formKey;
  late Task task;
  late String taskId;
  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    task = Task.fromMap(Get.arguments['task']);
    taskId = Get.arguments['taskId'];
    super.onInit();
  }

  Future<void> updateTask() async {
    formKey.currentState?.save();
    await TaskRepository.instance.updateById(task, taskId);
    Get.back();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
