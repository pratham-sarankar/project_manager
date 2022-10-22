import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/models/project.dart';
import 'package:project_manager/app/data/repositories/project_repository.dart';
import 'package:project_manager/app/data/repositories/user_repository.dart';

class HomeController extends GetxController {
  String? get userName => UserRepository.instance.currentUser?.displayName;

  String get greeting {
    var now = DateTime.now();
    if (now.hour <= 10) {
      return "Good Morning!";
    } else if (now.hour <= 14) {
      return "Good Afternoon!";
    } else {
      return "Good Evening!";
    }
  }

  late RxString sortBy;
  late RxBool ascending;
  late RxList<QueryDocumentSnapshot<Project>> projects;
  late RxString photoUrl;

  @override
  void onInit() {
    sortBy = 'Priority'.obs;
    ascending = true.obs;
    photoUrl = (UserRepository.instance.currentUser?.photoURL ??
            'https://i.stack.imgur.com/34AD2.jpg')
        .obs;
    projects = <QueryDocumentSnapshot<Project>>[].obs;
    ProjectRepository.instance.streamAll().listen((event) {
      projects.value = event.docs;
      sort();
    });
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

  void tweekAscending() {
    ascending.value = !ascending.value;
  }

  void sortByPriority() async {
    sortBy.value = 'Priority';
    List<String> userPriorities =
        await UserRepository.instance.fetchAllProjectPriorities();
    projects.sort(
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
        await UserRepository.instance.fetchAllProjectStatuses();
    projects.sort(
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

  void sortByDeadline() {
    projects.sort(
      (a, b) {
        var first = a.data().deadline ?? Timestamp.now();
        var second = b.data().deadline ?? Timestamp.now();
        return first.compareTo(second);
      },
    );
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
      case ('Deadline'):
        sortByDeadline();
        break;
    }
  }
}
