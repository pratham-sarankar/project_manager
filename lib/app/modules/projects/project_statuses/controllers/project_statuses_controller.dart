import 'package:get/get.dart';
import 'package:project_manager/app/data/repositories/project_repository.dart';
import 'package:project_manager/app/data/repositories/user_repository.dart';

class ProjectStatusesController extends GetxController {
  late RxList<String> statuses;
  @override
  void onInit() {
    statuses = <String>[].obs;
    initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    statuses.value = await UserRepository.instance.fetchAllProjectStatuses();
    var allStatuses = await ProjectRepository.instance.fetchAllStatuses();
    allStatuses.removeWhere((element) => !allStatuses.contains(element));
    for (var priority in allStatuses) {
      statuses.addIf(!statuses.contains(priority), priority);
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
    await UserRepository.instance.saveProjectStatuses(statuses);
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
