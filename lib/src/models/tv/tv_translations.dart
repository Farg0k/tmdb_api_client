class TvTranslation {
  final String iso_3166_1;
  final String iso_639_1;
  final String name;
  final String englishName;
  final TvTranslationData data;

  TvTranslation({
    required this.iso_3166_1,
    required this.iso_639_1,
    required this.name,
    required this.englishName,
    required this.data,
  });

  factory TvTranslation.fromJson(Map<String, dynamic> json) {
    return TvTranslation(
      iso_3166_1: json['iso_3166_1'] as String,
      iso_639_1: json['iso_639_1'] as String,
      name: json['name'] as String,
      englishName: json['english_name'] as String,
      data: TvTranslationData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class TvTranslationData {
  final String name;
  final String overview;
  final String tagline;
  final String homepage;

  TvTranslationData({
    required this.name,
    required this.overview,
    required this.tagline,
    required this.homepage,
  });

  factory TvTranslationData.fromJson(Map<String, dynamic> json) {
    return TvTranslationData(
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      homepage: json['homepage'] as String? ?? '',
    );
  }
}

class TvTranslationsResponse {
  final int id;
  final List<TvTranslation> translations;

  TvTranslationsResponse({required this.id, required this.translations});

  factory TvTranslationsResponse.fromJson(Map<String, dynamic> json) {
    return TvTranslationsResponse(
      id: json['id'] as int,
      translations: (json['translations'] as List)
          .map((i) => TvTranslation.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
