/// [AlternativeName] represents an alternative name for a company or network.
class AlternativeName {
  final String name;
  final String type;

  AlternativeName({
    required this.name,
    required this.type,
  });

  factory AlternativeName.fromJson(Map<String, dynamic> json) {
    return AlternativeName(
      name: (json['name'] ?? json['title']) as String,
      type: json['type'] as String? ?? '',
    );
  }
}
