import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.065),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Text(
                  Get.arguments['newUser']
                      ? "Create an account"
                      : "Welcome back!",
                  style: TextStyle(
                    fontSize: Get.height * 0.0246,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Image.asset(
                  'assets/login.png',
                ),
                CupertinoTextField(
                  controller: controller.phoneNumberController,
                  padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.016,
                    horizontal: Get.width * 0.02,
                  ),
                  placeholder: "Enter your phone number",
                  keyboardType: TextInputType.phone,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefix: Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.03),
                    child: const Icon(Icons.phone, color: Colors.grey),
                  ),
                  prefixMode: OverlayVisibilityMode.always,
                  placeholderStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: Get.height * 0.02,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.022,
                ),
                Obx(() {
                  return ElevatedButton(
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
                      controller.continueWithPhoneNumber();
                    },
                    child: SizedBox(
                      width: Get.width,
                      child: Center(
                        child: Text(
                          controller.isLoading.value
                              ? "Loading..."
                              : "Continue",
                          style: TextStyle(
                            fontSize: Get.height * 0.018,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        height: Get.height * 0.08,
                      ),
                    ),
                    const Text("  OR  "),
                    Expanded(
                      child: Divider(
                        height: Get.height * 0.08,
                      ),
                    ),
                  ],
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
                    overlayColor:
                        MaterialStatePropertyAll(Colors.grey.shade300),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {
                    controller.continueWithGoogle();
                  },
                  child: SizedBox(
                    width: Get.width,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/google_logo.png",
                            height: Get.height * 0.025,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Continue with Google",
                            style: TextStyle(
                              fontSize: Get.height * 0.018,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
