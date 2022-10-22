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
}
