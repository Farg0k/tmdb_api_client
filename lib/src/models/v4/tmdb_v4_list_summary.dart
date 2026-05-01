/// [TmdbListV4Summary] represents a concise version of a v4 list.
class TmdbListV4Summary {
  final String? backdropPath;
  final String description;
  final int id;
  final String iso_639_1;
  final int itemCount;
  final String name;
  final String? posterPath;
  final bool public;
  final double revenue;
  final int runtime;
  final String sortBy;

  TmdbListV4Summary({
    this.backdropPath,
    required this.description,
    required this.id,
    required this.iso_639_1,
    required this.itemCount,
    required this.name,
    this.posterPath,
    required this.public,
    required this.revenue,
    required this.runtime,
    required this.sortBy,
  });

  factory TmdbListV4Summary.fromJson(Map<String, dynamic> json) {
    return TmdbListV4Summary(
      backdropPath: json['backdrop_path'] as String?,
      description: json['description'] as String? ?? '',
      id: json['id'] as int,
      iso_639_1: json['iso_639_1'] as String? ?? '',
      itemCount: json['item_count'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      public: json['public'] as bool? ?? false,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      runtime: json['runtime'] as int? ?? 0,
      sortBy: json['sort_by'] as String? ?? '',
    );
  }
}
