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
      body: const Row(
        children: [
          // 왼쪽 영역 - 속성 테이블
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ColumnTableScreen(showAppBar: false),
            ),
          ),
          // 오른쪽 영역 - 수식 입력 + 디버깅 결과
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('수식 입력',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  FormulaInputScreen(),
                  SizedBox(height: 16),
                  Text('디버깅 결과 (추후 추가)', style: TextStyle(fontSize: 16)),
                  // 여기에 디버깅 결과 화면 추가할 예정
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
