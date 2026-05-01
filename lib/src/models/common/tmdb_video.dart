/// [TmdbVideo] represents a video related to a movie or TV show (e.g., trailer).
class TmdbVideo {
  final String iso_639_1;
  final String iso_3166_1;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;

  TmdbVideo({
    required this.iso_639_1,
    required this.iso_3166_1,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory TmdbVideo.fromJson(Map<String, dynamic> json) {
    return TmdbVideo(
      iso_639_1: json['iso_639_1'] as String? ?? '',
      iso_3166_1: (json['iso_3166_1'] ?? json['iso_3116_1']) as String? ?? '',
      name: json['name'] as String? ?? '',
      key: json['key'] as String? ?? '',
      site: json['site'] as String? ?? '',
      size: json['size'] as int? ?? 0,
      type: json['type'] as String? ?? '',
      official: json['official'] as bool? ?? false,
      publishedAt: json['published_at'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );
  }
}
