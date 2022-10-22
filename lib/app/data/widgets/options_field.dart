import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionsField extends StatelessWidget {
  const OptionsField(
      {Key? key,
      required this.onSelected,
      required this.options,
      this.prefixImagePath,
      this.placeHolder,
      this.initialValue})
      : super(key: key);
  final Function(String) onSelected;
  final List<String> options;
  final String? prefixImagePath;
  final String? placeHolder;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.035),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Image.asset(
                prefixImagePath ?? '',
                height: Get.height * 0.025,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Autocomplete<String>(
                displayStringForOption: (option) => option,
                initialValue: TextEditingValue(text: initialValue ?? ''),
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return options.where((String option) {
                    return option
                        .toString()
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  onSelected(selection);
                },
                fieldViewBuilder: (context, textEditingController, focusNode,
                    onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    cursorHeight: Get.height * 0.032,
                    style: context.textTheme.titleLarge!.copyWith(
                      fontSize: Get.height * 0.022,
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value) {
                      onSelected(value);
                    },
                    enabled: true,
                    onTap: () async {},
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: placeHolder,
                      hintStyle: context.textTheme.bodyMedium!.copyWith(
                        fontSize: Get.height * 0.023,
                        color: Colors.grey,
                      ),
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 15),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
