import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/formula_provider.dart';
import '../components/formula_item.dart';
import '../services/formula_evaluator.dart';

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

  void insertFormula(String targetFormula, [bool isFunction = false]) {
    focusNode.requestFocus();

    final selection = controller.selection;
    final text = controller.text;

    final int start = selection.start >= 0 ? selection.start : text.length;
    final int end = selection.end >= 0 ? selection.end : text.length;

    final newText = text.replaceRange(start, end, targetFormula);

    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: start + targetFormula.length + (isFunction ? -1 : 0),
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
                print(evaluate(ref.read(formulaProvider)));
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
        const SizedBox(height: 10),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormulaHeader(name: "속성"),
                      const FormulaHeader(name: "빌트인"),
                      FormulaItem(
                          name: "not",
                          icon: Icons.check_box_outlined,
                          onInsert: () => insertFormula("not")),
                      FormulaItem(
                          name: "true",
                          icon: Icons.check_box_outlined,
                          onInsert: () => insertFormula("true")),
                      FormulaItem(
                          name: "false",
                          icon: Icons.check_box_outlined,
                          onInsert: () => insertFormula("false")),
                      const FormulaHeader(name: "함수"),
                      FormulaItem(
                          name: "if ()",
                          icon: Icons.functions,
                          onInsert: () => insertFormula("if()", true)),
                      FormulaItem(
                          name: "ifs ()",
                          icon: Icons.functions,
                          onInsert: () => insertFormula("ifs()", true)),
                      FormulaItem(
                          name: "and()",
                          icon: Icons.check_box_outlined,
                          onInsert: () => insertFormula("and()", true)),
                      FormulaItem(
                          name: "or()",
                          icon: Icons.check_box_outlined,
                          onInsert: () => insertFormula("or()", true)),
                      FormulaItem(
                          name: "not()",
                          icon: Icons.check_box_outlined,
                          onInsert: () => insertFormula("not()", true)),
                      FormulaItem(
                          name: "empty()",
                          icon: Icons.check_box_outlined,
                          onInsert: () => insertFormula("empty()", true)),
                      FormulaItem(
                          name: "length()",
                          icon: Icons.numbers,
                          onInsert: () => insertFormula("length()", true)),
                      FormulaItem(
                          name: "substring()",
                          icon: Icons.subject,
                          onInsert: () => insertFormula("substring()", true)),
                      FormulaItem(
                          name: "contains()",
                          icon: Icons.check_box_outlined,
                          onInsert: () => insertFormula("contains()", true)),
                      FormulaItem(
                          name: "test()",
                          icon: Icons.check_box_outlined,
                          onInsert: () => insertFormula("test()", true)),
                      FormulaItem(
                          name: "match()",
                          icon: Icons.subject,
                          onInsert: () => insertFormula("match()", true)),
                      FormulaItem(
                          name: "replace()",
                          icon: Icons.subject,
                          onInsert: () => insertFormula("replace()", true)),
                      FormulaItem(
                          name: "replaceAll()",
                          icon: Icons.subject,
                          onInsert: () => insertFormula("replaceAll()", true)),
                      FormulaItem(
                          name: "lower()",
                          icon: Icons.subject,
                          onInsert: () => insertFormula("lower()", true)),
                      FormulaItem(
                          name: "upper()",
                          icon: Icons.subject,
                          onInsert: () => insertFormula("upper()", true)),
                      FormulaItem(
                          name: "repeat()",
                          icon: Icons.subject,
                          onInsert: () => insertFormula("repeat()", true)),
                      FormulaItem(
                          name: "padStart()",
                          icon: Icons.subject,
                          onInsert: () => insertFormula("padStart()", true)),
                      FormulaItem(
                          name: "padEnd()",
                          icon: Icons.subject,
                          onInsert: () => insertFormula("padEnd()", true)),
                    ],
                  ),
                ),
              ),
              const Expanded(child: Column(children: [])),
            ],
          ),
        ),
      ],
    );
  }
}
