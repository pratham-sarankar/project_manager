import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/models/project.dart';
import 'package:project_manager/app/data/repositories/project_repository.dart';
import 'package:project_manager/app/routes/app_pages.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile(
      {Key? key,
      required this.project,
      required this.onTap,
      this.taskLength,
      required this.projectId})
      : super(key: key);
  final Project project;
  final String projectId;
  final int? taskLength;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.065,
          ),
          onTap: onTap,
          subtitle: Opacity(
            opacity: 0.8,
            child: Text(
              taskLength == null ? "No Tasks" : "$taskLength tasks",
              style: TextStyle(
                fontSize: Get.height * 0.015,
              ),
            ),
          ),
          leading: Container(
            height: Get.height * 0.046,
            width: Get.width * 0.1,
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  width: Get.width * 0.05,
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor.withOpacity(0.6),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.elliptical(30, 100),
                      bottomLeft: Radius.circular(100),
                    ),
                  ),
                ),
                Container(
                  height: Get.height * 0.04,
                  decoration: BoxDecoration(
                    color: context.theme.primaryColorDark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                      right: 10, left: 10, bottom: Get.height * 0.012),
                  child: Container(
                    height: Get.height * 0.003,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            project.name,
            style: TextStyle(
              fontSize: Get.height * 0.018,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      title: Text(project.name),
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
                          child: const Text(
                            'Show Details',
                          ),
                          onPressed: () {
                            Get.back();
                            Get.toNamed(
                              Routes.PROJECT_DETAILS,
                              arguments: {
                                'project': project.toMap(),
                                'projectId': projectId,
                              },
                            );
                          },
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            Get.back();
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text("Are you sure?"),
                                  actions: [
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('No'),
                                    ),
                                    CupertinoDialogAction(
                                      isDestructiveAction: true,
                                      onPressed: () {
                                        ProjectRepository.instance
                                            .deleteById(projectId);
                                        Get.back();
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          isDestructiveAction: true,
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.more_horiz)),
        ),
        Divider(height: 1, thickness: 1, color: Colors.grey.shade300)
      ],
    );
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.only(
          right: Get.width * 0.022,
          left: Get.width * 0.028,
          top: Get.height * 0.018,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * 0.046,
                  width: Get.width * 0.1,
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        width: Get.width * 0.05,
                        decoration: BoxDecoration(
                          color: context.theme.primaryColor.withOpacity(0.6),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.elliptical(30, 100),
                            bottomLeft: Radius.circular(100),
                          ),
                        ),
                      ),
                      Container(
                        height: Get.height * 0.04,
                        decoration: BoxDecoration(
                          color: context.theme.primaryColorDark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(
                            right: 10, left: 10, bottom: Get.height * 0.012),
                        child: Container(
                          height: Get.height * 0.003,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              project.name,
              style: TextStyle(
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: Text(
                taskLength == null ? "No Tasks" : "$taskLength tasks",
                style: TextStyle(
                  fontSize: Get.height * 0.015,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
