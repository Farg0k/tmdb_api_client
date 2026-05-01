/// [TmdbJob] represents a department and its associated jobs.
class TmdbJob {
  final String department;
  final List<String> jobs;

  TmdbJob({required this.department, required this.jobs});

  factory TmdbJob.fromJson(Map<String, dynamic> json) {
    return TmdbJob(
      department: json['department'] as String,
      jobs: (json['jobs'] as List).map((e) => e as String).toList(),
    );
  }
}

/// [TmdbApiConfigDetails] represents the static configuration details (e.g., image base URLs).
class TmdbApiConfigDetails {
  final List<String> backdropSizes;
  final String baseUrl;
  final List<String> logoSizes;
  final List<String> posterSizes;
  final List<String> profileSizes;
  final String secureBaseUrl;
  final List<String> stillSizes;
  final List<String> changeKeys;

  TmdbApiConfigDetails({
    required this.backdropSizes,
    required this.baseUrl,
    required this.logoSizes,
    required this.posterSizes,
    required this.profileSizes,
    required this.secureBaseUrl,
    required this.stillSizes,
    required this.changeKeys,
  });

  factory TmdbApiConfigDetails.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as Map<String, dynamic>;
    return TmdbApiConfigDetails(
      backdropSizes: (images['backdrop_sizes'] as List)
          .map((e) => e as String)
          .toList(),
      baseUrl: images['base_url'] as String,
      logoSizes: (images['logo_sizes'] as List)
          .map((e) => e as String)
          .toList(),
      posterSizes: (images['poster_sizes'] as List)
          .map((e) => e as String)
          .toList(),
      profileSizes: (images['profile_sizes'] as List)
          .map((e) => e as String)
          .toList(),
      secureBaseUrl: images['secure_base_url'] as String,
      stillSizes: (images['still_sizes'] as List)
          .map((e) => e as String)
          .toList(),
      changeKeys: (json['change_keys'] as List)
          .map((e) => e as String)
          .toList(),
    );
  }
}
