/// [TvAccountStates] represents the status of a TV series for a specific user.
class TvAccountStates {
  final int id;
  final bool favorite;
  final dynamic rated; // Can be bool or Map with 'value'
  final bool watchlist;

  TvAccountStates({
    required this.id,
    required this.favorite,
    required this.rated,
    required this.watchlist,
  });

  factory TvAccountStates.fromJson(Map<String, dynamic> json) {
    return TvAccountStates(
      id: json['id'] as int,
      favorite: json['favorite'] as bool,
      rated: json['rated'],
      watchlist: json['watchlist'] as bool,
    );
  }

  double? get ratingValue {
    if (rated is Map) {
      return (rated['value'] as num).toDouble();
    }
    return null;
  }
}
