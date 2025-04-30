import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/property.dart';
import '../providers/property_provider.dart';

class ColumnTableScreen extends ConsumerWidget {
  const ColumnTableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertiesProvider);
    final rows = ref.watch(rowsProvider);
    final formula = ref.watch(formulaProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              defaultColumnWidth: const IntrinsicColumnWidth(),
              border: TableBorder.all(color: Colors.grey.shade300),
              children: [
                // 헤더
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  children: [
                    for (var property in properties)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          property.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    // 새 속성 추가 버튼
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          ref.read(propertiesProvider.notifier).addProperty();
                          ref
                              .read(rowsProvider.notifier)
                              .addColumnToRows('속성 ${properties.length}');
                        },
                      ),
                    ),
                  ],
                ),
                // 데이터
                for (int rowIndex = 0; rowIndex < rows.length; rowIndex++)
                  TableRow(
                    children: [
                      for (var property in properties)
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: property.isFormula
                              ? Text(
                                  rows[rowIndex][property.name]?.toString() ??
                                      '')
                              : TextFormField(
                                  initialValue: rows[rowIndex][property.name]
                                          ?.toString() ??
                                      '',
                                  onChanged: (value) {
                                    ref
                                        .read(rowsProvider.notifier)
                                        .updateRowValue(
                                          rowIndex,
                                          property.name,
                                          _castValue(property.type, value),
                                        );
                                  },
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                        ),
                      const SizedBox.shrink(), // 새 속성 추가 버튼 열
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(rowsProvider.notifier).addRow(properties);
            },
            icon: const Icon(Icons.add),
            label: const Text('새 행 추가'),
          ),
          const SizedBox(height: 32),
          // 수식 입력창
          TextFormField(
            initialValue: formula,
            onChanged: (value) {
              ref.read(formulaProvider.notifier).state = value;
              ref.read(rowsProvider.notifier).updateFormulaResults(value);
            },
            decoration: const InputDecoration(
              labelText: '수식 입력',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  dynamic _castValue(PropertyType type, String value) {
    switch (type) {
      case PropertyType.number:
        return num.tryParse(value);
      case PropertyType.checkbox:
        return value.toLowerCase() == 'true';
      case PropertyType.date:
        return value;
      case PropertyType.text:
      default:
        return value;
    }
  }
}
