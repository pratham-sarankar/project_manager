import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/repositories/user_repository.dart';
import 'package:project_manager/app/data/widgets/updatable_text.dart';
import 'package:project_manager/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: controller.photoUrl.value);
        return false;
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
          title: const Text("Profile"),
        ),
        body: ListView(
          children: [
            SizedBox(height: Get.height * 0.01),
            Obx(
              () => Center(
                child: GestureDetector(
                  onTap: () async {
                    String? url =
                        await UserRepository.instance.updatePhotoUrl();
                    if (url != null) {
                      controller.photoUrl.value = url;
                    }
                  },
                  child: CircleAvatar(
                    radius: Get.height * 0.05,
                    backgroundImage: NetworkImage(controller.photoUrl.value),
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.015),
            UpdatableText(
              UserRepository.instance.currentUser?.displayName ?? "User Name",
              style: TextStyle(
                fontSize: Get.height * 0.022,
                fontWeight: FontWeight.w600,
              ),
              onUpdate: (value) {
                UserRepository.instance.updateDisplayName(value);
              },
            ),
            UpdatableText(
              UserRepository.instance.currentUser?.email ?? "example@mail.com",
              style: TextStyle(fontSize: Get.height * 0.02),
              onUpdate: (value) {},
            ),
            SizedBox(height: Get.height * 0.05),
            const Divider(height: 0.5, thickness: 0.5),
            ListTile(
              title: Text("Task Priorities",
                  style: TextStyle(
                      color: Colors.black, fontSize: Get.height * 0.022)),
              onTap: () {
                Get.toNamed(Routes.TASK_PRIORITIES);
              },
              minLeadingWidth: 0,
              horizontalTitleGap: 20,
              leading: Icon(
                Icons.task_alt,
                size: Get.height * 0.032,
                color: Colors.black,
              ),
            ),
            const Divider(height: 0.5, thickness: 0.5),
            ListTile(
              title: Text("Task Statuses",
                  style: TextStyle(
                      color: Colors.black, fontSize: Get.height * 0.022)),
              onTap: () {
                Get.toNamed(Routes.TASK_STATUS);
              },
              minLeadingWidth: 0,
              horizontalTitleGap: 20,
              leading: Icon(
                Icons.circle_outlined,
                size: Get.height * 0.032,
                color: Colors.black,
              ),
            ),
            const Divider(height: 0.5, thickness: 0.5),
            ListTile(
              title: Text("Log out",
                  style: TextStyle(
                      color: Colors.black, fontSize: Get.height * 0.022)),
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text("Are you sure?"),
                      actions: [
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          onPressed: () async {
                            await UserRepository.instance.signOut();
                            Get.offAllNamed(Routes.GET_STARTED);
                          },
                          child: const Text("Yes"),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("No"),
                        ),
                      ],
                    );
                  },
                );
              },
              minLeadingWidth: 0,
              horizontalTitleGap: 20,
              leading: Icon(
                Icons.logout,
                size: Get.height * 0.032,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
