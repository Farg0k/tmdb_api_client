/// [MediaAccountStates] represents the user status for a movie, TV show, or episode.
class MediaAccountStates {
  final int id;
  final bool? favorite;
  final double? rating;
  final bool? watchlist;

  MediaAccountStates({
    required this.id,
    this.favorite,
    this.rating,
    this.watchlist,
  });

  factory MediaAccountStates.fromJson(Map<String, dynamic> json) {
    double? rating;
    if (json['rated'] is Map) {
      rating = (json['rated']['value'] as num).toDouble();
    }

    return MediaAccountStates(
      id: json['id'] as int,
      favorite: json['favorite'] as bool?,
      rating: rating,
      watchlist: json['watchlist'] as bool?,
    );
  }

  /// Backward compatibility for the old 'rated' field logic.
  double? get ratingValue => rating;

  /// Returns true if the item has been rated by the user.
  bool get isRated => rating != null;
}
