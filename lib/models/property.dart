// Property 모델 정의

enum PropertyType {
  text,
  number,
  date,
  checkbox,
}

class Property {
  String name;
  PropertyType type;
  dynamic value;

  Property({
    required this.name,
    required this.type,
    this.value,
  });
}
