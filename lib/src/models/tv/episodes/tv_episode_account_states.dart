
/// [TvEpisodeAccountStates] represents the user rating status for a specific TV episode.
class TvEpisodeAccountStates {
  final int id;
  final dynamic rated; // Can be bool or Map with 'value'

  TvEpisodeAccountStates({required this.id, required this.rated});

  factory TvEpisodeAccountStates.fromJson(Map<String, dynamic> json) {
    return TvEpisodeAccountStates(
      id: json['id'] as int,
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
