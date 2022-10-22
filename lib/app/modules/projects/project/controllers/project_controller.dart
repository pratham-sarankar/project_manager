import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/models/task.dart';
import 'package:project_manager/app/data/repositories/task_repository.dart';
import 'package:project_manager/app/data/repositories/user_repository.dart';

class ProjectController extends GetxController {
  late final String projectId;
  late RxList<QueryDocumentSnapshot<Task>> tasks;
  late RxString sortBy;
  late RxBool ascending;
  @override
  void onInit() {
    projectId = Get.parameters['projectId']!;
    sortBy = 'Priority'.obs;
    ascending = true.obs;
    tasks = <QueryDocumentSnapshot<Task>>[].obs;
    TaskRepository.instance.streamAllByProjectId(projectId).listen((event) {
      tasks.value = event.docs;
      sort();
    });
    super.onInit();
  }

  void tweekAscending() {
    ascending.value = !ascending.value;
  }

  @override
  void onReady() {
    super.onReady();
  }

  void sortByPriority() async {
    sortBy.value = 'Priority';
    List<String> userPriorities =
        await UserRepository.instance.fetchAllTaskPriorities();
    tasks.sort(
      (a, b) {
        var firstIndex = userPriorities.indexOf(a.data().priority);
        var secondIndex = userPriorities.indexOf(b.data().priority);
        if (firstIndex == -1 || secondIndex == -1) {
          return 1;
        } else {
          return firstIndex.compareTo(secondIndex);
        }
      },
    );
    notifyChildrens();
  }

  void sortByStatus() async {
    sortBy.value = 'Status';
    List<String> userPriorities =
        await UserRepository.instance.fetchAllTaskStatuses();
    tasks.sort(
      (a, b) {
        var firstIndex = userPriorities.indexOf(a.data().status);
        var secondIndex = userPriorities.indexOf(b.data().status);
        if (firstIndex == -1 || secondIndex == -1) {
          return 1;
        } else {
          return firstIndex.compareTo(secondIndex);
        }
      },
    );
    notifyChildrens();
  }

  void sortByStartDate() {
    sortBy.value = 'Start Date';
    tasks.sort((a, b) {
      var start = a.data().startDate?.toDate() ?? DateTime.now();
      var end = b.data().startDate?.toDate() ?? DateTime.now();
      return start.compareTo(end);
    });
    notifyChildrens();
  }

  void sortByEndDate() {
    sortBy.value = 'End Date';
    tasks.sort((a, b) {
      var start = a.data().endDate?.toDate() ?? DateTime.now();
      var end = b.data().endDate?.toDate() ?? DateTime.now();
      return start.compareTo(end);
    });
    notifyChildrens();
  }

  void sort({String? value}) {
    switch (value ?? sortBy.value) {
      case ('Priority'):
        sortByPriority();
        break;
      case ('Status'):
        sortByStatus();
        break;
      case ('Start Date'):
        sortByStartDate();
        break;
      case ('End Date'):
        sortByEndDate();
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
