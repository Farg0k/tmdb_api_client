import '../keyword_models.dart';

class TvKeywordsResponse {
  final int id;
  final List<Keyword> results;

  TvKeywordsResponse({required this.id, required this.results});

  factory TvKeywordsResponse.fromJson(Map<String, dynamic> json) {
    return TvKeywordsResponse(
      id: json['id'] as int,
      results: (json['results'] as List)
          .map((i) => Keyword.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
