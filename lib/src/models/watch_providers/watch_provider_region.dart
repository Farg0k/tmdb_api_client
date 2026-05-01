/// [WatchProviderRegion] represents a region supported by TMDB watch providers.
class WatchProviderRegion {
  final String iso_3166_1;
  final String englishName;
  final String nativeName;

  WatchProviderRegion({
    required this.iso_3166_1,
    required this.englishName,
    required this.nativeName,
  });

  factory WatchProviderRegion.fromJson(Map<String, dynamic> json) {
    return WatchProviderRegion(
      iso_3166_1: json['iso_3166_1'] as String,
      englishName: json['english_name'] as String,
      nativeName: json['native_name'] as String,
    );
  }
}
