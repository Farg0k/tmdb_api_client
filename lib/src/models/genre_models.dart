/// [Genre] represents a single media genre.
class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

/// [GenresResponse] contains a list of genres for movies or TV shows.
class GenresResponse {
  final List<Genre> genres;

  GenresResponse({required this.genres});

  factory GenresResponse.fromJson(Map<String, dynamic> json) {
    return GenresResponse(
      genres: (json['genres'] as List)
          .map((item) => Genre.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
