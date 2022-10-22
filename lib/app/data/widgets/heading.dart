import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
    required this.title,
    this.padding,
    this.actions,
  }) : super(key: key);
  final String title;
  final EdgeInsets? padding;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            right: Get.width * 0.065,
            left: Get.width * 0.065,
            top: Get.height * 0.035,
            bottom: Get.height * 0.015,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: Get.height * 0.0185,
            ),
          ),
          const Spacer(),
          ...actions ?? [],
        ],
      ),
    );
  }
}
