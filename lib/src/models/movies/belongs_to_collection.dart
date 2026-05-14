/// [BelongsToCollection] represents the collection a movie belongs to.
class BelongsToCollection {
  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;

  BelongsToCollection({
    required this.id,
    required this.name,
    this.posterPath,
    this.backdropPath,
  });

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) {
    return BelongsToCollection(
      id: json['id'] as int,
      name: json['name'] as String,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
    );
  }

  @override
  String toString() {
    return '''BelongsToCollection{
      id: $id, 
      name: $name, 
      posterPath: $posterPath, 
      backdropPath: $backdropPath
    }''';
  }
}
