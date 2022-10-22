import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/repositories/project_repository.dart';
import 'package:project_manager/app/data/widgets/description_field.dart';
import 'package:project_manager/app/data/widgets/name_field.dart';
import 'package:project_manager/app/data/widgets/options_field.dart';
import 'package:project_manager/app/data/widgets/time_field.dart';
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
              DescriptionField(
                onSaved: (description) {
                  if (description != null) {
                    controller.project.description = description;
                  }
                },
              ),
              TimeField(
                placeHolder: "Add Deadline",
                prefixImagePath: 'assets/deadline.png',
                onUpdate: (deadline) {
                  if (deadline != null) {
                    controller.project.deadline = Timestamp.fromDate(deadline);
                  }
                },
              ),
              StreamBuilder(
                stream: ProjectRepository.instance.streamAllPriorities(),
                builder: (context, snapshot) {
                  return OptionsField(
                    prefixImagePath: 'assets/priority.png',
                    placeHolder: "Add Priority",
                    onSelected: (selection) {
                      controller.project.priority = selection;
                    },
                    options: snapshot.data ?? [],
                  );
                },
              ),
              StreamBuilder(
                stream: ProjectRepository.instance.streamAllStatuses(),
                builder: (context, snapshot) {
                  return OptionsField(
                    prefixImagePath: 'assets/status.png',
                    placeHolder: "Add Status",
                    onSelected: (selection) {
                      controller.project.status = selection;
                    },
                    options: snapshot.data ?? [],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
