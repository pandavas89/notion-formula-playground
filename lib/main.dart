import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/column_table_screen.dart';
import 'screens/formula_input_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notion Formula Playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PlaygroundHome(),
    );
  }
}

class PlaygroundHome extends ConsumerWidget {
  const PlaygroundHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notion Formula Playground'),
      ),
      body: Row(
        children: [
          // 왼쪽 영역 - 속성 테이블
          const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ColumnTableScreen(),
            ),
          ),
          // 오른쪽 영역 - 수식 입력 + 디버깅 결과
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormulaInputScreen(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
