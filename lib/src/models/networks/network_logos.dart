/// [NetworkLogo] represents a single logo image for a TV network.
class NetworkLogo {
  final double aspectRatio;
  final String filePath;
  final int height;
  final String id;
  final String? fileType;
  final double voteAverage;
  final int voteCount;
  final int width;

  NetworkLogo({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.id,
    this.fileType,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory NetworkLogo.fromJson(Map<String, dynamic> json) {
    return NetworkLogo(
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

class NetworkLogosResponse {
  final int id;
  final List<NetworkLogo> logos;

  NetworkLogosResponse({
    required this.id,
    required this.logos,
  });

  factory NetworkLogosResponse.fromJson(Map<String, dynamic> json) {
    return NetworkLogosResponse(
      id: json['id'] as int,
      logos: (json['logos'] as List)
          .map((i) => NetworkLogo.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
