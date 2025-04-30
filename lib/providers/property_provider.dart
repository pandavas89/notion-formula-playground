import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/property.dart';

// 속성 리스트 Provider
final propertiesProvider =
    StateNotifierProvider<PropertyListNotifier, List<Property>>((ref) {
  return PropertyListNotifier();
});

class PropertyListNotifier extends StateNotifier<List<Property>> {
  PropertyListNotifier()
      : super([
          Property(
              name: '수식 결과',
              type: PropertyType.text,
              isFormula: true), // 기본 수식 컬럼
        ]);

  void addProperty() {
    state = [
      ...state.sublist(0, state.length - 1),
      Property(name: '속성 ${state.length}', type: PropertyType.text),
      state.last, // 수식 결과는 항상 마지막
    ];
  }
}

// 행 데이터 Provider
final rowsProvider =
    StateNotifierProvider<RowListNotifier, List<Map<String, dynamic>>>((ref) {
  return RowListNotifier();
});

class RowListNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  RowListNotifier() : super([]);

  void addRow(List<Property> properties) {
    final newRow = {for (var p in properties) p.name: null};
    state = [...state, newRow];
  }

  void addColumnToRows(String columnName) {
    state = [
      for (final row in state) {...row, columnName: null}
    ];
  }

  void updateRowValue(int rowIndex, String propertyName, dynamic newValue) {
    final updated = [...state];
    updated[rowIndex][propertyName] = newValue;
    state = updated;
  }

  void updateFormulaResults(String formula) {
    // 지금은 간단히: 수식이 숫자 1이면 1을 출력, 아니면 0 출력하는 더미 평가
    final result = (formula.trim() == '1') ? 1 : 0;
    state = [
      for (final row in state) {...row, '수식 결과': result},
    ];
  }
}

// 수식 입력 Provider
final formulaProvider = StateProvider<String>((ref) => '');
