import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/project_priorities_controller.dart';

class ProjectPrioritiesView extends GetView<ProjectPrioritiesController> {
  const ProjectPrioritiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await controller.updatePriorities();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          titleSpacing: 0,
          titleTextStyle:
              TextStyle(color: Colors.black, fontSize: Get.height * 0.025),
          title: const Text("Project Priorities"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await controller.updatePriorities();
          },
          backgroundColor: context.theme.primaryColorDark,
          child: const Icon(Icons.save),
        ),
        body: Obx(() {
          return ReorderableListView(
            onReorder: controller.onReorder,
            children: [
              for (int i = 0; i < controller.priorities.length; i++)
                Column(
                  key: UniqueKey(),
                  children: [
                    ListTile(
                      title: Text("${i + 1}.  ${controller.priorities[i]}"),
                      minLeadingWidth: 0,
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.shade300,
                    )
                  ],
                ),
            ],
          );
        }),
      ),
    );
  }
}
