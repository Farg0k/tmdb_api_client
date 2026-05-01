/// [PersonTranslation] represents a translation for a person's metadata.
class PersonTranslation {
  final String iso_3166_1;
  final String iso_639_1;
  final String name;
  final String englishName;
  final PersonTranslationData data;

  PersonTranslation({
    required this.iso_3166_1,
    required this.iso_639_1,
    required this.name,
    required this.englishName,
    required this.data,
  });

  factory PersonTranslation.fromJson(Map<String, dynamic> json) {
    return PersonTranslation(
      iso_3166_1: json['iso_3166_1'] as String,
      iso_639_1: json['iso_639_1'] as String,
      name: json['name'] as String,
      englishName: json['english_name'] as String,
      data: PersonTranslationData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class PersonTranslationData {
  final String biography;

  PersonTranslationData({required this.biography});

  factory PersonTranslationData.fromJson(Map<String, dynamic> json) {
    return PersonTranslationData(
      biography: json['biography'] as String? ?? '',
    );
  }
}

class PersonTranslationsResponse {
  final int id;
  final List<PersonTranslation> translations;

  PersonTranslationsResponse({required this.id, required this.translations});

  factory PersonTranslationsResponse.fromJson(Map<String, dynamic> json) {
    return PersonTranslationsResponse(
      id: json['id'] as int,
      translations: (json['translations'] as List)
          .map((i) => PersonTranslation.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
