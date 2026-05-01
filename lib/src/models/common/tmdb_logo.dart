/// [TmdbLogo] represents a single logo image for a company or network.
class TmdbLogo {
  final double aspectRatio;
  final String filePath;
  final int height;
  final String id;
  final String? fileType;
  final double voteAverage;
  final int voteCount;
  final int width;

  TmdbLogo({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.id,
    this.fileType,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory TmdbLogo.fromJson(Map<String, dynamic> json) {
    return TmdbLogo(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble() ?? 0.0,
      filePath: json['file_path'] as String? ?? '',
      height: json['height'] as int? ?? 0,
      id: json['id']?.toString() ?? '',
      fileType: json['file_type'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      width: json['width'] as int? ?? 0,
    );
  }
}
