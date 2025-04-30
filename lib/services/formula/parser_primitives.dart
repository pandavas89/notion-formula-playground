import 'package:petitparser/petitparser.dart';

void addPrimitives(ExpressionBuilder builder, Parser expression) {
  builder.primitive(digit().plus().flatten().trim().map(int.parse));
  builder.primitive(string('true').trim().map((_) => true));
  builder.primitive(string('false').trim().map((_) => false));

  builder.primitive(
    (char('(').trim() & expression.trim() & char(')').trim())
        .map((values) => values[1]),
  );

  // if(...)
  builder.primitive(
    (string('if').trim() &
            char('(').trim() &
            expression
                .trim()
                .separatedBy(char(',').trim(), includeSeparators: false) &
            char(')').trim())
        .map((values) {
      final args = values[2] as List<dynamic>;
      if (args.length != 3) throw 'if() requires 3 arguments';
      return args[0] ? args[1] : args[2];
    }),
  );

  // ifs(...)
  builder.primitive(
    (string('ifs').trim() &
            char('(').trim() &
            expression
                .trim()
                .separatedBy(char(',').trim(), includeSeparators: false) &
            char(')').trim())
        .map((values) {
      final args = values[2] as List<dynamic>;
      for (var i = 0; i < args.length - 1; i += 2) {
        if (args[i] == true) return args[i + 1];
      }
      return args.last;
    }),
  );

  // length
  builder.primitive(
    (string('length').trim() &
            char('(').trim() &
            expression.trim() &
            char(')').trim())
        .map((values) {
      final arg = values[2];
      if (arg == null) return 0;
      final str = arg.toString();
      return str.length;
    }),
  );

  // empty
  builder.primitive(
    (string('empty').trim() &
            char('(').trim() &
            expression.trim() &
            char(')').trim())
        .map((values) {
      final arg = values[2];
      if (arg == null) return true;
      if (arg is String && arg.isEmpty) return true;
      if (arg is List && arg.isEmpty) return true;
      return false;
    }),
  );

  builder.primitive(
    (char('"') & any().starLazy(char('"')).flatten() & char('"'))
        .map((values) => values[1]),
  );
}
