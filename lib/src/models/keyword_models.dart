/// [Keyword] represents a single keyword tag on TMDB.
class Keyword {
  final int id;
  final String name;

  Keyword({required this.id, required this.name});

  factory Keyword.fromJson(Map<String, dynamic> json) {
    return Keyword(id: json['id'] as int, name: json['name'] as String);
  }
}
