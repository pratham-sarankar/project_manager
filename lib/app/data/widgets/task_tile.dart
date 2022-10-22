import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/models/task.dart';
import 'package:project_manager/app/data/repositories/task_repository.dart';
import 'package:project_manager/app/routes/app_pages.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task, required this.taskId})
      : super(key: key);
  final Task task;
  final String taskId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.TASK_DETAILS,
          arguments: {
            'task': task.toMap(),
            'taskId': taskId,
          },
        );
      },
      child: Container(
        width: Get.width,
        margin: EdgeInsets.only(
          right: Get.width * 0.06,
          left: Get.width * 0.06,
          bottom: Get.height * 0.016,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              offset: const Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * 0.12,
              height: Get.width * 0.12,
              decoration: BoxDecoration(
                color: context.theme.primaryColor.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.task,
                color: context.theme.primaryColorDark,
                size: Get.height * 0.032,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                        fontSize: Get.height * 0.018,
                        fontWeight: FontWeight.w600),
                  ),
                  if (task.description.isNotEmpty)
                    Column(
                      children: [
                        const SizedBox(height: 2),
                        Opacity(
                          opacity: 0.6,
                          child: Text(
                            task.description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: Get.height * 0.016),
                          ),
                        ),
                      ],
                    ),
                  if (task.priority.isNotEmpty)
                    Column(
                      children: [
                        const SizedBox(height: 2),
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            task.priority,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: Get.height * 0.016),
                          ),
                        ),
                      ],
                    ),
                  if (task.startDate != null && task.endDate != null)
                    Column(
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              formatTime(task.startDate!),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Get.height * 0.016,
                                color: Colors.green.shade700,
                              ),
                            ),
                            Text(
                              " - ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Get.height * 0.016,
                              ),
                            ),
                            Text(
                              formatTime(task.endDate!),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Get.height * 0.016,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (task.status.isNotEmpty)
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            task.status,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Get.height * 0.016,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return CupertinoActionSheet(
                        title: Text(task.title),
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        actions: [
                          CupertinoActionSheetAction(
                            child: const Text('Show Details'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
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
                                          TaskRepository.instance
                                              .deleteById(taskId);
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
          ],
        ),
      ),
    );
  }

  String formatTime(Timestamp timestamp) {
    var dateTime = timestamp.toDate();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
