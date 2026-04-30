/// [TmdbCountry] represents a country supported by TMDB.
class TmdbCountry {
  final String iso_3166_1;
  final String englishName;
  final String? nativeName;

  TmdbCountry({
    required this.iso_3166_1,
    required this.englishName,
    this.nativeName,
  });

  factory TmdbCountry.fromJson(Map<String, dynamic> json) {
    return TmdbCountry(
      iso_3166_1: json['iso_3166_1'] as String,
      englishName: json['english_name'] as String,
      nativeName: json['native_name'] as String?,
    );
  }
}

/// [TmdbJob] represents a department and its associated jobs.
class TmdbJob {
  final String department;
  final List<String> jobs;

  TmdbJob({
    required this.department,
    required this.jobs,
  });

  factory TmdbJob.fromJson(Map<String, dynamic> json) {
    return TmdbJob(
      department: json['department'] as String,
      jobs: (json['jobs'] as List).map((e) => e as String).toList(),
    );
  }
}

/// [TmdbLanguage] represents a language supported by TMDB.
class TmdbLanguage {
  final String iso_639_1;
  final String englishName;
  final String name;

  TmdbLanguage({
    required this.iso_639_1,
    required this.englishName,
    required this.name,
  });

  factory TmdbLanguage.fromJson(Map<String, dynamic> json) {
    return TmdbLanguage(
      iso_639_1: json['iso_639_1'] as String,
      englishName: json['english_name'] as String,
      name: json['name'] as String,
    );
  }
}

/// [TmdbTimezone] represents a timezone supported by TMDB.
class TmdbTimezone {
  final String iso_3166_1;
  final List<String> zones;

  TmdbTimezone({
    required this.iso_3166_1,
    required this.zones,
  });

  factory TmdbTimezone.fromJson(Map<String, dynamic> json) {
    return TmdbTimezone(
      iso_3166_1: json['iso_3166_1'] as String,
      zones: (json['zones'] as List).map((e) => e as String).toList(),
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
      backdropSizes: (images['backdrop_sizes'] as List).map((e) => e as String).toList(),
      baseUrl: images['base_url'] as String,
      logoSizes: (images['logo_sizes'] as List).map((e) => e as String).toList(),
      posterSizes: (images['poster_sizes'] as List).map((e) => e as String).toList(),
      profileSizes: (images['profile_sizes'] as List).map((e) => e as String).toList(),
      secureBaseUrl: images['secure_base_url'] as String,
      stillSizes: (images['still_sizes'] as List).map((e) => e as String).toList(),
      changeKeys: (json['change_keys'] as List).map((e) => e as String).toList(),
    );
  }
}
