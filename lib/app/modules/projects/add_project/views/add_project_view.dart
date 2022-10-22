import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/repositories/project_repository.dart';
import 'package:project_manager/app/data/widgets/name_field.dart';
import 'package:project_manager/app/modules/projects/add_project/controllers/add_project_controller.dart';

class AddProjectView extends GetView<AddProjectController> {
  const AddProjectView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.theme.primaryColorDark,
        onPressed: () async {
          controller.formKey.currentState?.save();
          await ProjectRepository.instance.insertOne(controller.project);
          Get.back();
        },
        child: const Icon(Icons.check),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: Get.height * 0.02,
          bottom: Get.height * 0.025,
          right: Get.width * 0.06,
          left: Get.width * 0.06,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              NameField(
                title: "Project name",
                onSaved: (name) {
                  if (name != null) {
                    controller.project.name = name;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
