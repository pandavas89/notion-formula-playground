import 'package:flutter/material.dart';
import '../components/brace_colored_preview.dart';

class FormulaEditor extends StatefulWidget {
  final String initialValue;
  final void Function(String) onChanged;

  const FormulaEditor({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<FormulaEditor> createState() => _FormulaEditorState();
}

class _FormulaEditorState extends State<FormulaEditor> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(() {
      widget.onChanged(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 하이라이팅 텍스트
        Positioned.fill(
          child: IgnorePointer(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BraceColoredTextPreview(formula: _controller.text),
            ),
          ),
        ),
        // 투명 입력 필드
        TextField(
          controller: _controller,
          style: const TextStyle(
            fontFamily: 'Courier',
            fontSize: 14,
            color: Colors.orange,
            decorationColor: Colors.transparent,
          ),
          strutStyle: const StrutStyle(fontSize: 14, forceStrutHeight: true),
          cursorColor: Colors.black,
          maxLines: null,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(16),
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }
}
