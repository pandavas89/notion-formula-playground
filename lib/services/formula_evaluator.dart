import 'package:petitparser/petitparser.dart';

import 'formula/parser_entry.dart';

dynamic evaluate(String input) {
  final parser = buildExpressionParser();
  final result = parser.parse(input);
  return result is Success ? result.value : '파싱 실패';
}
