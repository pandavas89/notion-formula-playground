import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/formula_provider.dart';
import '../components/formula_item.dart';

class FormulaInputScreen extends ConsumerStatefulWidget {
  const FormulaInputScreen({super.key});

  @override
  ConsumerState<FormulaInputScreen> createState() => _FormulaInputScreenState();
}

class _FormulaInputScreenState extends ConsumerState<FormulaInputScreen> {
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    final formula = ref.read(formulaProvider);
    controller = TextEditingController(text: formula);
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _launchUrl() async {
    final Uri uri = Uri.parse("https://www.notion.com/ko/help/formulas");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch';
    }
  }

  void insertFormula(String targetFormula) {
    focusNode.requestFocus();

    final selection = controller.selection;
    final text = controller.text;

    final int start = selection.start >= 0 ? selection.start : text.length;
    final int end = selection.end >= 0 ? selection.end : text.length;

    final newText = text.replaceRange(start, end, targetFormula);

    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: selection.start + targetFormula.length,
      ),
    );

    ref.read(formulaProvider.notifier).state = newText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Notion 수식"),
            const SizedBox(width: 10),
            Tooltip(
              preferBelow: false,
              message: "수식에 대해 자세히 알아보세요!",
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: GestureDetector(
                onTap: _launchUrl,
                child: const Icon(Icons.help_outline),
              ),
            ),
            const Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                // 저장 로직
              },
              child: const Text("저장"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            focusNode: focusNode,
            controller: controller,
            onChanged: (value) =>
                ref.read(formulaProvider.notifier).state = value,
            maxLines: null,
            style: const TextStyle(fontFamily: 'Courier', fontSize: 14),
            decoration: const InputDecoration.collapsed(
              hintText: '사용자의 수식',
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormulaHeader(name: "속성"),
                  const FormulaHeader(name: "빌트인"),
                  FormulaItem(
                    name: "not",
                    icon: Icons.check_box_outlined,
                    onInsert: () => insertFormula("not"),
                  ),
                  FormulaItem(
                    name: "true",
                    icon: Icons.check_box_outlined,
                    onInsert: () => insertFormula("true"),
                  ),
                  FormulaItem(
                    name: "false",
                    icon: Icons.check_box_outlined,
                    onInsert: () => insertFormula("false"),
                  ),
                  const FormulaHeader(name: "함수"),
                ],
              ),
            ),
            const Expanded(child: Column(children: [])),
          ],
        ),
      ],
    );
  }
}
