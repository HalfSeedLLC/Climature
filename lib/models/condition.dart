import 'dart:convert';

class Condition {
  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  final String text;
  final String icon;
  final int code;

  Condition copyWith({
    String? text,
    String? icon,
    int? code,
  }) {
    return Condition(
      text: text ?? this.text,
      icon: icon ?? this.icon,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'icon': icon,
      'code': code,
    };
  }

  factory Condition.fromMap(Map<String, dynamic> map) {
    return Condition(
      text: map['text'] as String,
      icon: map['icon'] as String,
      code: map['code'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Condition.fromJson(String source) =>
      Condition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Condition other) {
    if (identical(this, other)) return true;

    return other.text == text && other.icon == icon && other.code == code;
  }

  @override
  int get hashCode => text.hashCode ^ icon.hashCode ^ code.hashCode;

  @override
  String toString() => 'Condition(text: $text, icon: $icon, code: $code)';
}
