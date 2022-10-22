import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/models/project.dart';
import 'package:project_manager/app/data/models/task.dart';
import 'package:project_manager/app/data/repositories/task_repository.dart';
import 'package:project_manager/app/data/widgets/heading.dart';
import 'package:project_manager/app/data/widgets/project_tile.dart';
import 'package:project_manager/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.toNamed(Routes.ADD_PROJECT);
        },
        isExtended: true,
        backgroundColor: context.theme.primaryColorDark,
        child: const Icon(
          Icons.add_task_rounded,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              // const SizedBox(height: 70),
              Obx(
                () => _AppBar(
                  title: "Hello, ${controller.userName ?? 'User'}!",
                  subTitle: controller.greeting,
                  photoUrl: controller.photoUrl.value,
                  updatePhotoUrl: (value) {
                    controller.photoUrl.value = value;
                  },
                ),
              ),
              // const _SearchField(),
              Heading(
                title: "Projects",
                actions: [
                  GestureDetector(
                    child: const Icon(Icons.more_horiz),
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            title: const Text('Projects'),
                            cancelButton: CupertinoActionSheetAction(
                              child: const Text(
                                'Cancel',
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Get.toNamed(Routes.ALL_TASKS);
                                },
                                isDefaultAction: true,
                                child: const Text(
                                  'View All Tasks',
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),

              Obx(() {
                if (controller.projects.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.04),
                    child: Image.asset('assets/no_projects.png'),
                  );
                } else {
                  return Container();
                }
              }),
              Obx(() {
                List<QueryDocumentSnapshot<Project>> projects =
                    (controller.ascending.value
                            ? controller.projects
                            : controller.projects.reversed)
                        .toList();
                return Column(
                  children: projects
                      .map((project) => StreamBuilder<QuerySnapshot<Task>>(
                          stream: TaskRepository.instance
                              .streamAllByProjectId(project.id),
                          builder: (context, taskSnapshot) {
                            return ProjectTile(
                                project: project.data(),
                                projectId: project.id,
                                taskLength: taskSnapshot.data?.docs.length,
                                onTap: () {
                                  Get.toNamed(
                                    Routes.PROJECT,
                                    parameters: {'projectId': project.id},
                                  );
                                });
                          }))
                      .toList(),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.updatePhotoUrl,
    this.photoUrl,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String? photoUrl;
  final Function(String) updatePhotoUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.065, vertical: Get.height * 0.025),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(
                subTitle,
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              var url = await Get.toNamed(Routes.PROFILE);
              if (url is String) {
                updatePhotoUrl(url);
              }
            },
            child: CircleAvatar(
              radius: Get.width * 0.055,
              backgroundImage: NetworkImage(
                  photoUrl ?? 'https://i.stack.imgur.com/34AD2.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.06,
        vertical: Get.height * 0.005,
      ),
      child: CupertinoSearchTextField(
        prefixInsets: EdgeInsets.only(left: Get.width * 0.03),
        prefixIcon: Icon(
          CupertinoIcons.search,
          size: Get.height * 0.025,
        ),
        suffixInsets: EdgeInsets.only(right: Get.width * 0.03),
        itemColor: Colors.black87,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        style: context.textTheme.bodyLarge!.copyWith(
          letterSpacing: 0.05,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.014,
          horizontal: Get.width * 0.02,
        ),
      ),
    );
  }
}
