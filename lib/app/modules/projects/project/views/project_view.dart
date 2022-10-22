import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/models/project.dart';
import 'package:project_manager/app/data/models/task.dart';
import 'package:project_manager/app/data/repositories/project_repository.dart';
import 'package:project_manager/app/data/widgets/heading.dart';
import 'package:project_manager/app/data/widgets/task_tile.dart';
import 'package:project_manager/app/routes/app_pages.dart';

import '../controllers/project_controller.dart';

class ProjectView extends GetView<ProjectController> {
  const ProjectView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_TASK,
              parameters: {'projectId': controller.projectId});
        },
        backgroundColor: context.theme.primaryColorDark,
        child: const Icon(Icons.add_task_rounded),
      ),
      body: StreamBuilder<Project>(
          stream: ProjectRepository.instance.streamById(controller.projectId),
          builder: (context, projectSnapshot) {
            return SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.01,
                    ),
                    child: Row(
                      children: [
                        BackButton(onPressed: () {
                          Get.back();
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.06,
                      vertical: Get.height * 0.005,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Projects",
                          style: context.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: Get.height * 0.0185,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: Get.height * 0.035,
                          color: Colors.grey.shade600,
                        ),
                        Text(
                          projectSnapshot.data?.name ?? 'Name',
                          style: context.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: Get.height * 0.0185,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    List<QueryDocumentSnapshot<Task>> tasks =
                        (controller.ascending.value
                                ? controller.tasks
                                : controller.tasks.reversed)
                            .toList();
                    return Column(children: [
                      Heading(
                        title: "All Tasks (${controller.tasks.length ?? 0})",
                        actions: [
                          PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: 'Priority',
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Priority'),
                                      const SizedBox(width: 6),
                                      if (controller.sortBy.value == 'Priority')
                                        Icon(Icons.check,
                                            size: Get.height * 0.032),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'Status',
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Status'),
                                      const SizedBox(width: 6),
                                      if (controller.sortBy.value == 'Status')
                                        Icon(Icons.check,
                                            size: Get.height * 0.032),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'Start Date',
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Start Date'),
                                      const SizedBox(width: 6),
                                      if (controller.sortBy.value ==
                                          'Start Date')
                                        Icon(Icons.check,
                                            size: Get.height * 0.032),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'End Date',
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('End Date'),
                                      const SizedBox(width: 6),
                                      if (controller.sortBy.value == 'End Date')
                                        Icon(Icons.check,
                                            size: Get.height * 0.032),
                                    ],
                                  ),
                                ),
                              ];
                            },
                            onSelected: (value) {
                              controller.sort(value: value);
                            },
                            padding: EdgeInsets.zero,
                            child: const Icon(Icons.sort_rounded),
                          ),
                          const SizedBox(width: 10),
                          Obx(
                            () => GestureDetector(
                                onTap: () {
                                  controller.tweekAscending();
                                },
                                child: controller.ascending.value
                                    ? const Icon(Icons.arrow_downward)
                                    : const Icon(Icons.arrow_upward)),
                          ),
                        ],
                      ),
                      if (tasks.isEmpty)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Get.height * 0.04),
                          child: Image.asset('assets/no_projects.png'),
                        ),
                      ...tasks
                              .map((task) => TaskTile(
                                    task: task.data(),
                                    taskId: task.id,
                                  ))
                              .toList() ??
                          [],
                    ]);
                  }),
                ],
              ),
            );
          }),
    );
  }
}
