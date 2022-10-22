import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeField extends StatefulWidget {
  const TimeField(
      {Key? key,
      required this.onUpdate,
      required this.placeHolder,
      required this.prefixImagePath,
      this.initialValue})
      : super(key: key);
  final void Function(DateTime?) onUpdate;
  final String placeHolder;
  final String prefixImagePath;
  final DateTime? initialValue;
  @override
  State<TimeField> createState() => TimeFieldState();
}

class TimeFieldState extends State<TimeField> {
  DateTime? _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = widget.initialValue;
  }

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
                widget.prefixImagePath,
                height: Get.height * 0.025,
                color: _dateTime == null ? Colors.grey : Colors.black,
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () async {
                DateTime? result = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 10000)),
                );
                widget.onUpdate(result);
                setState(() {
                  _dateTime = result;
                });
              },
              child: Text(
                getString(),
                style: context.textTheme.bodyMedium!.copyWith(
                  fontSize: Get.height * 0.023,
                  color: _dateTime == null ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String getString() {
    if (_dateTime == null) {
      return widget.placeHolder;
    } else {
      return '${_dateTime?.day}/${_dateTime?.month}/${_dateTime?.year}';
    }
  }
}
