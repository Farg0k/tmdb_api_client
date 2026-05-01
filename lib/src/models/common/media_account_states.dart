/// [MediaAccountStates] represents the user status for a movie, TV show, or episode.
class MediaAccountStates {
  final int id;
  final bool? favorite;
  final dynamic rated; // Can be bool or Map with 'value'
  final bool? watchlist;

  MediaAccountStates({
    required this.id,
    this.favorite,
    this.rated,
    this.watchlist,
  });

  factory MediaAccountStates.fromJson(Map<String, dynamic> json) {
    return MediaAccountStates(
      id: json['id'] as int,
      favorite: json['favorite'] as bool?,
      rated: json['rated'],
      watchlist: json['watchlist'] as bool?,
    );
  }

  double? get ratingValue {
    if (rated is Map) {
      return (rated['value'] as num).toDouble();
    }
    return null;
  }
}
