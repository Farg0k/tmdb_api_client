class TvContentRating {
  final String descriptors;
  final String iso_3166_1;
  final String rating;

  TvContentRating({
    required this.descriptors,
    required this.iso_3166_1,
    required this.rating,
  });

  factory TvContentRating.fromJson(Map<String, dynamic> json) {
    return TvContentRating(
      descriptors: (json['descriptors'] as List?)?.join(', ') ?? '',
      iso_3166_1: json['iso_3166_1'] as String,
      rating: json['rating'] as String,
    );
  }
}

class TvContentRatingsResponse {
  final int id;
  final List<TvContentRating> results;

  TvContentRatingsResponse({required this.id, required this.results});

  factory TvContentRatingsResponse.fromJson(Map<String, dynamic> json) {
    return TvContentRatingsResponse(
      id: json['id'] as int,
      results: (json['results'] as List)
          .map((i) => TvContentRating.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
