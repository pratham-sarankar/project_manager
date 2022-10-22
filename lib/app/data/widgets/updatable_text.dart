import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatableText extends StatefulWidget {
  const UpdatableText(this.text,
      {Key? key, required this.style, required this.onUpdate})
      : super(key: key);
  final String text;
  final TextStyle style;
  final Function(String) onUpdate;
  @override
  State<UpdatableText> createState() => _UpdatableTextState();
}

class _UpdatableTextState extends State<UpdatableText> {
  late bool _enabled;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _enabled = false;
    _controller = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          _enabled = !_enabled;
        });
      },
      child: TextField(
        controller: _controller,
        textAlign: TextAlign.center,
        enabled: _enabled,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          isDense: true,
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          setState(() {
            _enabled = !_enabled;
          });
          widget.onUpdate(_controller.text);
        },
        style: context.textTheme.bodyLarge!.copyWith(
          fontSize: widget.style.fontSize,
          fontWeight: widget.style.fontWeight,
        ),
      ),
    );
    // return Text(
    //   widget.text,
    //   style: widget.style,
    // );
  }
}
