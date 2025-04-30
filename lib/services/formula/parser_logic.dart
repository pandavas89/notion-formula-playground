import 'package:petitparser/petitparser.dart';

void addLogicOperators(ExpressionBuilder builder) {
  // not 연산자
  builder.group().prefix(string('not').trim(), (_, a) => !a);

  builder.group()
    ..left(string('and').trim(), (a, _, b) => a && b)
    ..left(string('or').trim(), (a, _, b) => a || b);
}
