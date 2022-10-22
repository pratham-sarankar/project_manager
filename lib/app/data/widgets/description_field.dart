import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DescriptionField extends StatefulWidget {
  const DescriptionField({Key? key, required this.onSaved, this.initialValue})
      : super(key: key);
  final void Function(String?) onSaved;
  final String? initialValue;
  @override
  State<DescriptionField> createState() => DescriptionFieldState();
}

class DescriptionFieldState extends State<DescriptionField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.04),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Image.asset(
                'assets/description.png',
                height: Get.height * 0.025,
                color: _controller.text.isEmpty ? Colors.grey : Colors.black,
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: _controller,
                cursorHeight: Get.height * 0.032,
                style: context.textTheme.titleLarge!.copyWith(
                  fontSize: Get.height * 0.022,
                  fontWeight: FontWeight.w500,
                ),
                onChanged: (newValue) {
                  setState(() {});
                },
                onSaved: (newValue) {
                  widget.onSaved(newValue);
                },
                maxLines: null,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Add Description",
                  hintStyle: context.textTheme.bodyMedium!.copyWith(
                    fontSize: Get.height * 0.023,
                    color: Colors.grey,
                  ),
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 15),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
