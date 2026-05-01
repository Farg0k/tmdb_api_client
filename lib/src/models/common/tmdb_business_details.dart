import '../common/tmdb_company.dart';

/// [TmdbBusinessDetails] represents the full information about a TV network or production company.
class TmdbBusinessDetails extends TmdbCompany {
  final String headquarters;
  final String homepage;
  final String? description;
  final int? parentCompanyId;

  TmdbBusinessDetails({
    required super.id,
    super.logoPath,
    required super.name,
    super.originCountry,
    required this.headquarters,
    required this.homepage,
    this.description,
    this.parentCompanyId,
  });

  factory TmdbBusinessDetails.fromJson(Map<String, dynamic> json) {
    return TmdbBusinessDetails(
      id: json['id'] as int,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String? ?? '',
      originCountry: json['origin_country'] as String? ?? '',
      headquarters: json['headquarters'] as String? ?? '',
      homepage: json['homepage'] as String? ?? '',
      description: json['description'] as String?,
      parentCompanyId: json['parent_company'] != null ? (json['parent_company'] as Map<String, dynamic>)['id'] as int? : null,
    );
  }
}
