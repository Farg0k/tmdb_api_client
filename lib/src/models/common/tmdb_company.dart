/// [TmdbCompany] represents a production company or a company summary in search results.
class TmdbCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String? originCountry;

  TmdbCompany({
    required this.id,
    this.logoPath,
    required this.name,
    this.originCountry,
  });

  factory TmdbCompany.fromJson(Map<String, dynamic> json) {
    return TmdbCompany(
      id: json['id'] as int,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String? ?? '',
      originCountry: json['origin_country'] as String?,
    );
  }

  @override
  String toString() {
    return '''TmdbCompany{
      id: $id, 
      logoPath: $logoPath, 
      name: $name, 
      originCountry: $originCountry
    }''';
  }
}
