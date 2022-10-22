import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/routes/app_pages.dart';

import '../controllers/get_started_controller.dart';

class GetStartedView extends GetView<GetStartedController> {
  const GetStartedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.065),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/get_started.png',
              height: Get.height * 0.4,
            ),
            Text(
              "Hey! Welcome",
              style: context.textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: Get.height * 0.005,
            ),
            Opacity(
              opacity: 0.6,
              child: Text(
                "We deliver on-demand organic fresh fruits directly from your nearby farms.",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontSize: Get.height * 0.017,
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.035,
            ),
            ElevatedButton(
              // padding: EdgeInsets.symmetric(
              //   vertical: Get.height * 0.018,
              // ),
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                    vertical: Get.height * 0.016,
                  ),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                Get.toNamed(
                  Routes.LOGIN,
                  arguments: {"newUser": true},
                );
              },
              child: SizedBox(
                width: Get.width,
                child: Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: Get.height * 0.018,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.022,
            ),
            TextButton(
              // padding: EdgeInsets.symmetric(
              //   vertical: Get.height * 0.018,
              // ),
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                    vertical: Get.height * 0.016,
                  ),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                ),
                overlayColor: MaterialStatePropertyAll(Colors.grey.shade300),
                backgroundColor: const MaterialStatePropertyAll(Colors.white),
              ),
              onPressed: () {
                Get.toNamed(
                  Routes.LOGIN,
                  arguments: {"newUser": false},
                );
              },
              child: SizedBox(
                width: Get.width,
                child: Center(
                  child: Text(
                    "I already have an account",
                    style: TextStyle(
                      fontSize: Get.height * 0.018,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
