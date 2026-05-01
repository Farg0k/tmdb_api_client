/// [NetworkDetails] represents the full information about a TV network.
class NetworkDetails {
  final String headquarters;
  final String homepage;
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  NetworkDetails({
    required this.headquarters,
    required this.homepage,
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory NetworkDetails.fromJson(Map<String, dynamic> json) {
    return NetworkDetails(
      headquarters: json['headquarters'] as String? ?? '',
      homepage: json['homepage'] as String? ?? '',
      id: json['id'] as int,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String? ?? '',
    );
  }
}
