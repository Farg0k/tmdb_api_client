/// [CompanySummary] represents a concise version of company data returned in search results.
class CompanySummary {
  final int id;
  final String? logoPath;
  final String name;
  final String? originCountry;

  CompanySummary({
    required this.id,
    this.logoPath,
    required this.name,
    this.originCountry,
  });

  factory CompanySummary.fromJson(Map<String, dynamic> json) {
    return CompanySummary(
      id: json['id'] as int,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String?,
    );
  }
}
