import 'package:petitparser/petitparser.dart';

void addMathOperators(ExpressionBuilder builder) {
  builder.group().prefix(char('-').trim(), (_, a) => -a);
  builder.group()
    ..left(char('*').trim(), (a, _, b) => a * b)
    ..left(char('/').trim(), (a, _, b) => a / b);
  builder.group()
    ..left(char('+').trim(), (a, _, b) => a + b)
    ..left(char('-').trim(), (a, _, b) => a - b);
}
