import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/property.dart';
import '../providers/property_provider.dart';

class ColumnTableScreen extends ConsumerWidget {
  final bool showAppBar; // 추가
  const ColumnTableScreen({super.key, this.showAppBar = true}); // 기본 true

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertiesProvider);

    final content = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final property = properties[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: TextFormField(
                      initialValue: property.name,
                      decoration: const InputDecoration(
                        labelText: '속성 이름',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => ref
                          .read(propertiesProvider.notifier)
                          .updatePropertyName(index, value),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: DropdownButton<PropertyType>(
                        value: property.type,
                        onChanged: (newType) {
                          if (newType != null) {
                            ref
                                .read(propertiesProvider.notifier)
                                .updatePropertyType(index, newType);
                          }
                        },
                        items: PropertyType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type.name),
                          );
                        }).toList(),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => ref
                          .read(propertiesProvider.notifier)
                          .deleteProperty(index),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                ref.read(propertiesProvider.notifier).addProperty(),
            child: const Text('+ 속성 추가'),
          ),
        ],
      ),
    );

    // AppBar 보이기/숨기기
    return showAppBar
        ? Scaffold(
            appBar: AppBar(title: const Text('속성 테이블')),
            body: content,
          )
        : content;
  }
}
