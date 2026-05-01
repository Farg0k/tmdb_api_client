import '../keyword_models.dart';

class MovieKeywordsResponse {
  final int id;
  final List<Keyword> keywords;

  MovieKeywordsResponse({required this.id, required this.keywords});

  factory MovieKeywordsResponse.fromJson(Map<String, dynamic> json) {
    return MovieKeywordsResponse(
      id: json['id'] as int,
      keywords: (json['keywords'] as List)
          .map((i) => Keyword.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
