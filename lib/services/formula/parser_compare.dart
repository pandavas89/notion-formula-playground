import 'package:petitparser/petitparser.dart';

void addCompareOperators(ExpressionBuilder builder) {
  builder.group()
    ..left(string('==').trim(), (a, _, b) => a == b)
    ..left(string('!=').trim(), (a, _, b) => a != b)
    ..left(string('>=').trim(), (a, _, b) => a >= b)
    ..left(string('<=').trim(), (a, _, b) => a <= b)
    ..left(char('>').trim(), (a, _, b) => a > b)
    ..left(char('<').trim(), (a, _, b) => a < b);
}
