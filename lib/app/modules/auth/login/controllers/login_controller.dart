import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager/app/data/repositories/user_repository.dart';
import 'package:project_manager/app/routes/app_pages.dart';

class LoginController extends GetxController {
  late TextEditingController phoneNumberController;
  late RxBool isLoading;
  @override
  void onInit() {
    isLoading = false.obs;
    phoneNumberController = TextEditingController()
      ..addListener(() {
        if (!phoneNumberController.text.startsWith('+')) {
          phoneNumberController.text = "+91 ${phoneNumberController.text}";
        }
      });
    super.onInit();
  }

  void _showSnackBar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 5,
        margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void continueWithPhoneNumber() {
    if (!phoneNumberController.text.isPhoneNumber) {
      return;
    }
    isLoading.value = true;
    UserRepository.instance.authenticateWithPhoneNumber(
      phoneNumber: phoneNumberController.text,
      codeSent: (verificationId, forceResendingToken) async {
        var smsCode = await Get.toNamed(Routes.OTP);
        if (smsCode is String) {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);
          await UserRepository.instance.authenticateWithCredentials(credential);
          isLoading.value = false;
          Get.offAllNamed(Routes.HOME);
        }
      },
      verificationCompleted: (phoneAuthCredential) async {
        await UserRepository.instance
            .authenticateWithCredentials(phoneAuthCredential);
        Get.offAllNamed(Routes.HOME);
      },
      verificationFailed: (error) {
        _showSnackBar("Verification failed");
        print("verification failed $error");
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  void continueWithGoogle() async {
    await UserRepository.instance.authenticateWithGoogle();
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
