/// [TvSeasonAccountStates] represents the user rating status for all episodes in a season.
class TvSeasonAccountStates {
  final int id;
  final List<TvEpisodeAccountState> results;

  TvSeasonAccountStates({required this.id, required this.results});

  factory TvSeasonAccountStates.fromJson(Map<String, dynamic> json) {
    return TvSeasonAccountStates(
      id: json['id'] as int,
      results: (json['results'] as List)
          .map((i) => TvEpisodeAccountState.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}

class TvEpisodeAccountState {
  final int id;
  final int episodeNumber;
  final dynamic rated; // Can be bool or Map with 'value'

  TvEpisodeAccountState({
    required this.id,
    required this.episodeNumber,
    required this.rated,
  });

  factory TvEpisodeAccountState.fromJson(Map<String, dynamic> json) {
    return TvEpisodeAccountState(
      id: json['id'] as int,
      episodeNumber: json['episode_number'] as int,
      rated: json['rated'],
    );
  }

  double? get ratingValue {
    if (rated is Map) {
      return (rated['value'] as num).toDouble();
    }
    return null;
  }
}
