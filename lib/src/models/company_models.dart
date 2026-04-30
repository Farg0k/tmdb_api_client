/// [CompanyDetails] represents the full information about a production company.
class CompanyDetails {
  final String? description;
  final String headquarters;
  final String homepage;
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;
  final int? parentCompanyId; // Using int? for simplicity, as TMDB returns a full object or null

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

/// [AlternativeName] represents an alternative name for a company.
class AlternativeName {
  final String name;
  final String type;

  AlternativeName({
    required this.name,
    required this.type,
  });

  factory AlternativeName.fromJson(Map<String, dynamic> json) {
    return AlternativeName(
      name: json['name'] as String,
      type: json['type'] as String,
    );
  }
}

/// [AlternativeNamesResponse] contains a list of alternative names for a company.
class AlternativeNamesResponse {
  final int id;
  final List<AlternativeName> results;

  AlternativeNamesResponse({
    required this.id,
    required this.results,
  });

  factory AlternativeNamesResponse.fromJson(Map<String, dynamic> json) {
    return AlternativeNamesResponse(
      id: json['id'] as int,
      results: (json['results'] as List)
          .map((item) => AlternativeName.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// [CompanyLogosResponse] contains a list of logos for a company.
class CompanyLogosResponse {
  final int id;
  final List<CompanyLogo> logos;

  CompanyLogosResponse({
    required this.id,
    required this.logos,
  });

  factory CompanyLogosResponse.fromJson(Map<String, dynamic> json) {
    return CompanyLogosResponse(
      id: json['id'] as int,
      logos: (json['logos'] as List)
          .map((item) => CompanyLogo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// [CompanyLogo] represents a single logo image for a company.
class CompanyLogo {
  final double aspectRatio;
  final String filePath;
  final int height;
  final String id;
  final String? fileType; // .svg, .png etc
  final double voteAverage;
  final int voteCount;
  final int width;

  CompanyLogo({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.id,
    this.fileType,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory CompanyLogo.fromJson(Map<String, dynamic> json) {
    return CompanyLogo(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      filePath: json['file_path'] as String,
      height: json['height'] as int,
      id: json['id'] as String,
      fileType: json['file_type'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      width: json['width'] as int,
    );
  }
}
