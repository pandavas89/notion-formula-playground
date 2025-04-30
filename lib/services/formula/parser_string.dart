import 'package:petitparser/petitparser.dart';

void addStringOperators(ExpressionBuilder builder, Parser expression) {
  // substring
  builder.primitive(
    (string('substring').trim() &
            char('(').trim() &
            expression
                .trim()
                .separatedBy(char(',').trim(), includeSeparators: false) &
            char(')').trim())
        .map((values) {
      final args = values[2] as List<dynamic>;
      if (args.length < 2 || args.length > 3) {
        throw 'substring() requires 2 or 3 arguments';
      }

      final str = args[0].toString();
      final start =
          args[1] is int ? args[1] : int.tryParse(args[1].toString()) ?? 0;
      final length = args.length == 3
          ? (args[2] is int ? args[2] : int.tryParse(args[2].toString()))
          : null;

      if (start < 0 || start >= str.length) return '';
      final end = length != null
          ? (start + length).clamp(start, str.length)
          : str.length;
      return str.substring(start, end);
    }),
  );

  // contains(text, substr)
  builder.primitive(
    (string('contains').trim() &
            char('(').trim() &
            expression
                .trim()
                .separatedBy(char(',').trim(), includeSeparators: false) &
            char(')').trim())
        .map((values) {
      final args = values[2] as List<dynamic>;
      if (args.length != 2) throw 'contains() requires 2 arguments';
      final source = args[0].toString();
      final target = args[1].toString();
      return source.contains(target);
    }),
  );
}
