import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/widgets/name_field.dart';

import '../controllers/project_details_controller.dart';

class ProjectDetailsView extends GetView<ProjectDetailsController> {
  const ProjectDetailsView({Key? key}) : super(key: key);
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
          await controller.updateProject();
        },
        child: const Icon(Icons.save),
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
                initialValue: controller.project.name,
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
