import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/formula_provider.dart';

class FormulaInputScreen extends ConsumerWidget {
  const FormulaInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formula = ref.watch(formulaProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: TextEditingController(text: formula)
          ..selection = TextSelection.collapsed(offset: formula.length),
        onChanged: (value) => ref.read(formulaProvider.notifier).state = value,
        maxLines: null,
        style: const TextStyle(fontFamily: 'Courier', fontSize: 14),
        decoration: const InputDecoration.collapsed(
          hintText: '여기에 수식을 입력하세요...',
        ),
      ),
    );
  }
}
