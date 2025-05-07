import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/highlight_core.dart';

/// Notion 수식 전용 문법 정의
final notionFormulaMode = Mode(
  // name: 'notionFormula',
  contains: [
    // 함수 및 예약어
    Mode(
      className: 'keyword',
      begin:
          r'\b(if|ifs|not|and|or|empty|test|match|contains|replace|replaceAll|lower|upper|repeat|padStart|padEnd|substring|length|prop)\b',
    ),
    // 리터럴
    Mode(
      className: 'literal',
      begin: r'\b(true|false|null)\b',
    ),
    // 문자열
    Mode(
      className: 'string',
      begin: '"',
      end: '"',
    ),
    // 숫자
    Mode(
      className: 'number',
      begin: r'\b\d+(\.\d+)?\b',
    ),
    // 연산자
    Mode(
      className: 'operator',
      begin: r'[-+*/=<>!]+',
    ),
    // 구분자 및 괄호
    Mode(
      className: 'punctuation',
      begin: r'[(),]',
    ),
  ],
);

/// CodeController 생성 함수
CodeController buildFormulaCodeController(String initialText) {
  return CodeController(
    text: initialText,
    language: notionFormulaMode,
  );
}

/// 코드 하이라이팅 테마 설정
final Map<String, TextStyle> formulaHighlightTheme = {
  'root': const TextStyle(color: Colors.black, backgroundColor: Colors.white),
  'keyword': const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
  'literal': const TextStyle(color: Colors.deepPurple),
  'string': const TextStyle(color: Colors.green),
  'number': const TextStyle(color: Colors.orange),
  'operator': const TextStyle(color: Colors.redAccent),
  'punctuation': const TextStyle(color: Colors.grey),
};
