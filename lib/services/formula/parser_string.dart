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

  // match
  builder.primitive(
  (string('match').trim() &
   char('(').trim() &
   expression.trim().separatedBy(char(',').trim(), includeSeparators: false) &
   char(')').trim()).map((values) {
    final args = values[2] as List<dynamic>;
    if (args.length != 2) throw 'match() requires 2 arguments';
    final input = args[0].toString();
    final pattern = args[1].toString();

    final match = RegExp(pattern).firstMatch(input);
    return match?.group(0) ?? '';
  }),
);

  // replace
  builder.primitive(
  (string('replace').trim() &
   char('(').trim() &
   expression.trim().separatedBy(char(',').trim(), includeSeparators: false) &
   char(')').trim()).map((values) {
    final args = values[2] as List<dynamic>;
    if (args.length != 3) throw 'replace() requires 3 arguments';
    final input = args[0].toString();
    final pattern = args[1].toString();
    final replacement = args[2].toString();

    return input.replaceFirst(RegExp(pattern), replacement);
  }),
);

  // replaceAll
  builder.primitive(
  (string('replaceAll').trim() &
   char('(').trim() &
   expression.trim().separatedBy(char(',').trim(), includeSeparators: false) &
   char(')').trim()).map((values) {
    final args = values[2] as List<dynamic>;
    if (args.length != 3) throw 'replaceAll() requires 3 arguments';
    final input = args[0].toString();
    final pattern = args[1].toString();
    final replacement = args[2].toString();

    return input.replaceAll(RegExp(pattern), replacement);
  }),
);

  // lower
  builder.primitive(
  (string('lower').trim() &
   char('(').trim() &
   expression.trim() &
   char(')').trim()).map((values) {
    return values[2].toString().toLowerCase();
  }),
);

  // upper
  builder.primitive(
  (string('upper').trim() &
   char('(').trim() &
   expression.trim() &
   char(')').trim()).map((values) {
    return values[2].toString().toUpperCase();
  }),
);

  // repeat
  builder.primitive(
  (string('repeat').trim() &
   char('(').trim() &
   expression.trim().separatedBy(char(',').trim(), includeSeparators: false) &
   char(')').trim()).map((values) {
    final args = values[2] as List<dynamic>;
    if (args.length != 2) throw 'repeat() requires 2 arguments';
    final str = args[0].toString();
    final count = int.tryParse(args[1].toString()) ?? 0;
    return str * count;
  }),
);

  // padStart
  builder.primitive(
  (string('padStart').trim() &
   char('(').trim() &
   expression.trim().separatedBy(char(',').trim(), includeSeparators: false) &
   char(')').trim()).map((values) {
    final args = values[2] as List<dynamic>;
    if (args.length < 2 || args.length > 3) throw 'padStart() requires 2 or 3 arguments';

    final str = args[0].toString();
    final width = int.tryParse(args[1].toString()) ?? str.length;
    final padChar = args.length == 3 ? args[2].toString() : ' ';

    final padCount = (width - str.length).clamp(0, width);
    return padChar * padCount + str;
  }),
);

  // padEnd
  builder.primitive(
  (string('padEnd').trim() &
   char('(').trim() &
   expression.trim().plusSeparated(char(',').trim())
       .map((r) => r.elements) & // ✅ SeparatedValues → elements 추출
   char(')').trim())
      .map((values) {
        final args = values[2] as List<dynamic>; // ✅ 여기가 args
        if (args.length < 2 || args.length > 3) {
          throw 'padEnd() requires 2 or 3 arguments';
        }

        final str = args[0].toString();
        final width = int.tryParse(args[1].toString()) ?? str.length;
        final padChar = args.length == 3 ? args[2].toString() : ' ';

        final padCount = (width - str.length).clamp(0, width);
        return str + padChar * padCount;
      }),
  );

  // link
}
