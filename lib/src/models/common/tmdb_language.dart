/// [TmdbLanguage] represents a language metadata on TMDB.
class TmdbLanguage {
  final String iso_639_1;
  final String name;
  final String? englishName;

  TmdbLanguage({required this.iso_639_1, required this.name, this.englishName});

  factory TmdbLanguage.fromJson(Map<String, dynamic> json) {
    return TmdbLanguage(
      iso_639_1: json['iso_639_1'] as String,
      name: (json['name'] ?? json['english_name']) as String? ?? '',
      englishName: json['english_name'] as String?,
    );
  }
}
