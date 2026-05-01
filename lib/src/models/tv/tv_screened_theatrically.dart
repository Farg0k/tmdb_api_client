class TvScreenedTheatricallyEntry {
  final int id;
  final int episodeNumber;
  final int seasonNumber;

  TvScreenedTheatricallyEntry({
    required this.id,
    required this.episodeNumber,
    required this.seasonNumber,
  });

  factory TvScreenedTheatricallyEntry.fromJson(Map<String, dynamic> json) {
    return TvScreenedTheatricallyEntry(
      id: json['id'] as int,
      episodeNumber: json['episode_number'] as int,
      seasonNumber: json['season_number'] as int,
    );
  }
}

class TvScreenedTheatricallyResponse {
  final int id;
  final List<TvScreenedTheatricallyEntry> results;

  TvScreenedTheatricallyResponse({required this.id, required this.results});

  factory TvScreenedTheatricallyResponse.fromJson(Map<String, dynamic> json) {
    return TvScreenedTheatricallyResponse(
      id: json['id'] as int,
      results: (json['results'] as List)
          .map(
            (i) =>
                TvScreenedTheatricallyEntry.fromJson(i as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
