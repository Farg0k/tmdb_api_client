/// [TmdbTranslationData] contains the actual translated fields for various media types.
class TmdbTranslationData {
  final String? title; // For Movies
  final String? name; // For Collections, TV, etc.
  final String? overview;
  final String? homepage;
  final String? biography; // For People
  final String? tagline; // For Movies, TV
  final int? runtime; // For Movies

  TmdbTranslationData({
    this.title,
    this.name,
    this.overview,
    this.homepage,
    this.biography,
    this.tagline,
    this.runtime,
  });

  factory TmdbTranslationData.fromJson(Map<String, dynamic> json) {
    return TmdbTranslationData(
      title: json['title'] as String?,
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      homepage: json['homepage'] as String?,
      biography: json['biography'] as String?,
      tagline: json['tagline'] as String?,
      runtime: json['runtime'] as int?,
    );
  }

  @override
  String toString() {
    return 'TmdbTranslationData(title: $title, name: $name, overview: $overview, biography: $biography)';
  }
}

/// [TmdbTranslation] represents a single translation entry.
class TmdbTranslation {
  final String iso_3166_1;
  final String iso_639_1;
  final String name;
  final String englishName;
  final TmdbTranslationData data;

  TmdbTranslation({
    required this.iso_3166_1,
    required this.iso_639_1,
    required this.name,
    required this.englishName,
    required this.data,
  });

  factory TmdbTranslation.fromJson(Map<String, dynamic> json) {
    return TmdbTranslation(
      iso_3166_1: json['iso_3166_1'] as String? ?? '',
      iso_639_1: json['iso_639_1'] as String? ?? '',
      name: json['name'] as String? ?? '',
      englishName: json['english_name'] as String? ?? '',
      data: TmdbTranslationData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

/// [TmdbTranslationsResponse] is the container for all translations of an entity.
class TmdbTranslationsResponse {
  final int id;
  final List<TmdbTranslation> translations;

  TmdbTranslationsResponse({required this.id, required this.translations});

  factory TmdbTranslationsResponse.fromJson(Map<String, dynamic> json) {
    return TmdbTranslationsResponse(
      id: json['id'] as int? ?? 0,
      translations:
          (json['translations'] as List?)
              ?.map((i) => TmdbTranslation.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
