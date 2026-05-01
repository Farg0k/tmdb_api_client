/// [AlternativeTitle] represents an alternative title for a movie or TV show.
class AlternativeTitle {
  final String iso_3166_1;
  final String title;
  final String type;

  AlternativeTitle({
    required this.iso_3166_1,
    required this.title,
    required this.type,
  });

  factory AlternativeTitle.fromJson(Map<String, dynamic> json) {
    return AlternativeTitle(
      iso_3166_1: json['iso_3166_1'] as String,
      title: (json['title'] ?? json['name']) as String,
      type: json['type'] as String? ?? '',
    );
  }
}
