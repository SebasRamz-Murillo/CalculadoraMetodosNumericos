import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueNotifier<int> offsetNotifier;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.offsetNotifier,
  }) : super(key: key);

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      int offset = controller.selection.baseOffset;
      int newOffset = offset;
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        newOffset = (offset < controller.text.length) ? offset + 1 : offset;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        newOffset = (offset > 0) ? offset - 1 : offset;
      }

      controller.selection = TextSelection.collapsed(offset: newOffset);
      offsetNotifier.value = newOffset;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: _handleKeyEvent,
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            Math.tex(
              controller.text,
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: controller,
              focusNode: focusNode,
              style: const TextStyle(color: Colors.transparent),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Escribe aqui',
                hintStyle: TextStyle(color: Colors.transparent),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }
}
