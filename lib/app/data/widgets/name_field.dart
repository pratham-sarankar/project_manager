import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameField extends StatelessWidget {
  const NameField(
      {Key? key, required this.onSaved, required this.title, this.initialValue})
      : super(key: key);
  final void Function(String?) onSaved;
  final String? title;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return CupertinoTextFormFieldRow(
      placeholder: title,
      autofocus: true,
      onSaved: (newValue) {
        onSaved(newValue);
      },
      initialValue: initialValue,
      cursorHeight: Get.height * 0.045,
      style: context.textTheme.headline5!.copyWith(
        fontSize: Get.height * 0.03,
        fontWeight: FontWeight.w500,
      ),
      placeholderStyle: context.textTheme.headline5!.copyWith(
        fontSize: Get.height * 0.03,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(),
    );
  }
}
