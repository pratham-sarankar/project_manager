import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);
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
                SizedBox(height: Get.height * 0.08),
                Text(
                  "Verification",
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
                    "One-time password has been sent to the entered phone number. Please verify.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: Get.height * 0.017,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/otp.png',
                  height: Get.height * 0.4,
                ),
                SizedBox(
                  height: Get.height * 0.035,
                ),
                _OtpField(
                  otpControllers: controller.otpControllers,
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
                    minimumSize: MaterialStatePropertyAll(Size(Get.width, 0)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.back(result: controller.smsCode);
                  },
                  child: Text(
                    "Verify",
                    style: TextStyle(
                      fontSize: Get.height * 0.018,
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

class _OtpField extends StatelessWidget {
  const _OtpField({Key? key, required this.otpControllers}) : super(key: key);
  final List<TextEditingController> otpControllers;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: otpControllers
          .map(
            (e) => _OtpFieldBox(controller: e),
          )
          .toList(),
    );
  }
}

class _OtpFieldBox extends StatelessWidget {
  const _OtpFieldBox({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: CupertinoTextField(
        controller: controller,
        padding: const EdgeInsets.symmetric(vertical: 10),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
        textAlign: TextAlign.center,
        maxLength: 1,
      ),
    );
  }
}
