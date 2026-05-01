/// [PersonImage] represents a single profile image for a person.
class PersonImage {
  final double aspectRatio;
  final int height;
  final String? iso_639_1;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;

  PersonImage({
    required this.aspectRatio,
    required this.height,
    this.iso_639_1,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory PersonImage.fromJson(Map<String, dynamic> json) {
    return PersonImage(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      height: json['height'] as int,
      iso_639_1: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      width: json['width'] as int,
    );
  }
}

class PersonImagesResponse {
  final int id;
  final List<PersonImage> profiles;

  PersonImagesResponse({required this.id, required this.profiles});

  factory PersonImagesResponse.fromJson(Map<String, dynamic> json) {
    return PersonImagesResponse(
      id: json['id'] as int,
      profiles: (json['profiles'] as List)
          .map((i) => PersonImage.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
