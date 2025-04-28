import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/property.dart';

final propertiesProvider =
    StateNotifierProvider<PropertyListNotifier, List<Property>>((ref) {
  return PropertyListNotifier();
});

class PropertyListNotifier extends StateNotifier<List<Property>> {
  PropertyListNotifier() : super([]);

  void addProperty() {
    state = [
      ...state,
      Property(name: '속성 ${state.length + 1}', type: PropertyType.text),
    ];
  }

  void updatePropertyName(int index, String newName) {
    final updated = [...state];
    updated[index] = Property(
        name: newName, type: updated[index].type, value: updated[index].value);
    state = updated;
  }

  void updatePropertyType(int index, PropertyType newType) {
    final updated = [...state];
    updated[index] = Property(
        name: updated[index].name, type: newType, value: updated[index].value);
    state = updated;
  }

  void deleteProperty(int index) {
    final updated = [...state]..removeAt(index);
    state = updated;
  }
}
