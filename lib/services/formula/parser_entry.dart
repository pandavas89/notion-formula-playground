import 'package:petitparser/petitparser.dart';

import 'parser_primitives.dart';
import 'parser_math.dart';
import 'parser_logic.dart';
import 'parser_compare.dart';
import 'parser_string.dart';

Parser buildExpressionParser() {
  final expression = undefined();
  final builder = ExpressionBuilder();

  addPrimitives(builder, expression);
  addStringOperators(builder, expression);
  addMathOperators(builder);
  addCompareOperators(builder);
  addLogicOperators(builder);

  expression.set(builder.build().cast());
  return expression.end();
}
