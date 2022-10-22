import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/models/project.dart';

class AddProjectController extends GetxController {
  late GlobalKey<FormState> formKey;
  late Project project;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    project = Project();
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
}
