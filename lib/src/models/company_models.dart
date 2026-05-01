/// [CompanyDetails] represents the full information about a production company.
class CompanyDetails {
  final String? description;
  final String headquarters;
  final String homepage;
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;
  final int? parentCompanyId;

  CompanyDetails({
    this.description,
    required this.headquarters,
    required this.homepage,
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
    this.parentCompanyId,
  });

  factory CompanyDetails.fromJson(Map<String, dynamic> json) {
    return CompanyDetails(
      description: json['description'] as String?,
      headquarters: json['headquarters'] as String? ?? '',
      homepage: json['homepage'] as String? ?? '',
      id: json['id'] as int,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String? ?? '',
      parentCompanyId: json['parent_company'] != null ? (json['parent_company'] as Map<String, dynamic>)['id'] as int? : null,
    );
  }
}

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
