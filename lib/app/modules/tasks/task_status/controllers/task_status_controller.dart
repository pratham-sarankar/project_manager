import 'package:get/get.dart';
import 'package:project_manager/app/data/repositories/task_repository.dart';
import 'package:project_manager/app/data/repositories/user_repository.dart';

class TaskStatusController extends GetxController {
  late RxList<String> statuses;
  @override
  void onInit() {
    statuses = <String>[].obs;
    initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    statuses.value = await UserRepository.instance.fetchAllTaskStatuses();
    var allStatuses = await TaskRepository.instance.fetchAllStatuses();
    allStatuses.removeWhere((element) => !allStatuses.contains(element));
    for (var status in allStatuses) {
      statuses.addIf(!statuses.contains(status), status);
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final String item = statuses.removeAt(oldIndex);
    statuses.insert(newIndex, item);
  }

  Future<void> updateStatuses() async {
    await UserRepository.instance.saveTaskStatuses(statuses);
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
