import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  late final List<TextEditingController> otpControllers;

  @override
  void onInit() {
    otpControllers = List<TextEditingController>.generate(
        6, (index) => TextEditingController());
    super.onInit();
  }

  String get smsCode => otpControllers.fold(
      "", (previousValue, element) => "$previousValue${element.text}");

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
