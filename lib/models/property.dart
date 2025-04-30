enum PropertyType {
  text,
  number,
  date,
  checkbox,
}

class Property {
  final String name;
  final PropertyType type;
  final bool isFormula; // 수식 컬럼 여부

  Property({
    required this.name,
    required this.type,
    this.isFormula = false,
  });
}
