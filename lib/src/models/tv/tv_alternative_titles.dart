class TvAlternativeTitle {
  final String iso_3166_1;
  final String title;
  final String type;

  TvAlternativeTitle({
    required this.iso_3166_1,
    required this.title,
    required this.type,
  });

  factory TvAlternativeTitle.fromJson(Map<String, dynamic> json) {
    return TvAlternativeTitle(
      iso_3166_1: json['iso_3166_1'] as String,
      title: json['title'] as String,
      type: json['type'] as String? ?? '',
    );
  }
}

class TvAlternativeTitlesResponse {
  final int id;
  final List<TvAlternativeTitle> results;

  TvAlternativeTitlesResponse({required this.id, required this.results});

  factory TvAlternativeTitlesResponse.fromJson(Map<String, dynamic> json) {
    return TvAlternativeTitlesResponse(
      id: json['id'] as int,
      results: (json['results'] as List)
          .map((i) => TvAlternativeTitle.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
