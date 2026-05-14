/// [TmdbCountry] represents a country metadata on TMDB.
class TmdbCountry {
  final String iso_3166_1;
  final String name;
  final String? englishName;
  final String? nativeName;

  TmdbCountry({
    required this.iso_3166_1,
    required this.name,
    this.englishName,
    this.nativeName,
  });

  factory TmdbCountry.fromJson(Map<String, dynamic> json) {
    return TmdbCountry(
      iso_3166_1: json['iso_3166_1'] as String,
      name: (json['name'] ?? json['english_name']) as String? ?? '',
      englishName: json['english_name'] as String?,
      nativeName: json['native_name'] as String?,
    );
  }

  @override
  String toString() {
    return '''TmdbCountry{
      iso_3166_1: $iso_3166_1, 
      name: $name, 
      englishName: $englishName, 
      nativeName: $nativeName
    }''';
  }
}
