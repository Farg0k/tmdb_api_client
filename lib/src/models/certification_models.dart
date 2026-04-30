/// [Certification] represents a single age rating/certification.
class Certification {
  final String certification;
  final String meaning;
  final int order;

  Certification({
    required this.certification,
    required this.meaning,
    required this.order,
  });

  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification(
      certification: json['certification'] as String,
      meaning: json['meaning'] as String,
      order: json['order'] as int,
    );
  }
}

/// [CertificationsResponse] represents the response from TMDB certifications endpoints.
/// It maps country codes (e.g., 'US', 'UA') to a list of [Certification]s.
class CertificationsResponse {
  final Map<String, List<Certification>> certifications;

  CertificationsResponse({required this.certifications});

  factory CertificationsResponse.fromJson(Map<String, dynamic> json) {
    final rawCertifications = json['certifications'] as Map<String, dynamic>;
    final mappedCertifications = <String, List<Certification>>{};

    rawCertifications.forEach((country, list) {
      mappedCertifications[country] = (list as List)
          .map((item) => Certification.fromJson(item as Map<String, dynamic>))
          .toList();
    });

    return CertificationsResponse(certifications: mappedCertifications);
  }
}
