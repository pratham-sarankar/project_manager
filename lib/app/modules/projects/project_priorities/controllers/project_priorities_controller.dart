import 'package:get/get.dart';
import 'package:project_manager/app/data/repositories/project_repository.dart';
import 'package:project_manager/app/data/repositories/user_repository.dart';

class ProjectPrioritiesController extends GetxController {
  late RxList<String> priorities;
  @override
  void onInit() {
    priorities = <String>[].obs;
    initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    priorities.value = await UserRepository.instance.fetchAllProjectStatuses();
    var allPriorities = await ProjectRepository.instance.fetchAllPriorities();
    priorities.removeWhere((element) => !allPriorities.contains(element));
    for (var priority in allPriorities) {
      priorities.addIf(!priorities.contains(priority), priority);
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final String item = priorities.removeAt(oldIndex);
    priorities.insert(newIndex, item);
  }

  Future<void> updatePriorities() async {
    await UserRepository.instance.saveProjectPriorities(priorities);
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
