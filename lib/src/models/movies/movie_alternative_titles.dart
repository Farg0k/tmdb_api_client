/// [MovieAlternativeTitle] represents an alternative title for a movie in a specific country.
class MovieAlternativeTitle {
  final String iso_3166_1;
  final String title;
  final String type;

  MovieAlternativeTitle({
    required this.iso_3166_1,
    required this.title,
    required this.type,
  });

  factory MovieAlternativeTitle.fromJson(Map<String, dynamic> json) {
    return MovieAlternativeTitle(
      iso_3166_1: json['iso_3166_1'] as String,
      title: json['title'] as String,
      type: json['type'] as String? ?? '',
    );
  }
}

class MovieAlternativeTitlesResponse {
  final int id;
  final List<MovieAlternativeTitle> titles;

  MovieAlternativeTitlesResponse({required this.id, required this.titles});

  factory MovieAlternativeTitlesResponse.fromJson(Map<String, dynamic> json) {
    return MovieAlternativeTitlesResponse(
      id: json['id'] as int,
      titles: (json['titles'] as List)
          .map((i) => MovieAlternativeTitle.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
