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
