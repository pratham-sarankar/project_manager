import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/repositories/task_repository.dart';
import 'package:project_manager/app/data/widgets/description_field.dart';
import 'package:project_manager/app/data/widgets/name_field.dart';
import 'package:project_manager/app/data/widgets/options_field.dart';
import 'package:project_manager/app/data/widgets/time_field.dart';

import '../controllers/task_details_controller.dart';

class TaskDetailsView extends GetView<TaskDetailsController> {
  const TaskDetailsView({Key? key}) : super(key: key);
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
        child: const Icon(Icons.check),
        onPressed: () {
          controller.updateTask();
        },
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: EdgeInsets.only(
            top: Get.height * 0.02,
            bottom: Get.height * 0.025,
            right: Get.width * 0.06,
            left: Get.width * 0.06,
          ),
          child: Column(
            children: [
              NameField(
                title: "Title",
                initialValue: controller.task.title,
                onSaved: (name) {
                  if (name != null) {
                    controller.task.title = name;
                  }
                },
              ),
              DescriptionField(
                onSaved: (description) {
                  if (description != null) {
                    controller.task.description = description;
                  }
                },
                initialValue: controller.task.description,
              ),
              TimeField(
                placeHolder: "Start Date",
                prefixImagePath: 'assets/start_date.png',
                initialValue: controller.task.startDate?.toDate(),
                onUpdate: (deadline) {
                  if (deadline != null) {
                    controller.task.startDate = Timestamp.fromDate(deadline);
                  }
                },
              ),
              TimeField(
                placeHolder: "End Date",
                prefixImagePath: 'assets/end_date.png',
                initialValue: controller.task.endDate?.toDate(),
                onUpdate: (deadline) {
                  if (deadline != null) {
                    controller.task.endDate = Timestamp.fromDate(deadline);
                  }
                },
              ),
              StreamBuilder<List<String>>(
                stream: TaskRepository.instance.streamAllPriorities(),
                builder: (context, snapshot) {
                  return OptionsField(
                    prefixImagePath: 'assets/priority.png',
                    placeHolder: "Add Priority",
                    initialValue: controller.task.priority,
                    onSelected: (selection) {
                      controller.task.priority = selection;
                    },
                    options: snapshot.data ?? [],
                  );
                },
              ),
              StreamBuilder<List<String>>(
                stream: TaskRepository.instance.streamAllProgresses(),
                builder: (context, snapshot) {
                  return OptionsField(
                    prefixImagePath: 'assets/progress.png',
                    placeHolder: "Add Progress",
                    initialValue: controller.task.progress,
                    onSelected: (selection) {
                      controller.task.progress = selection;
                    },
                    options: snapshot.data ?? [],
                  );
                },
              ),
              StreamBuilder<List<String>>(
                stream: TaskRepository.instance.streamAllStatuses(),
                builder: (context, snapshot) {
                  return OptionsField(
                    prefixImagePath: 'assets/status.png',
                    placeHolder: "Add Status",
                    initialValue: controller.task.status,
                    onSelected: (selection) {
                      controller.task.status = selection;
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
