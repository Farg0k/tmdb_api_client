/// [MovieExternalIds] contains IDs for other databases and social media.
class MovieExternalIds {
  final int id;
  final String? imdbId;
  final String? wikidataId;
  final String? facebookId;
  final String? instagramId;
  final String? twitterId;

  MovieExternalIds({
    required this.id,
    this.imdbId,
    this.wikidataId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
  });

  factory MovieExternalIds.fromJson(Map<String, dynamic> json) {
    return MovieExternalIds(
      id: json['id'] as int,
      imdbId: json['imdb_id'] as String?,
      wikidataId: json['wikidata_id'] as String?,
      facebookId: json['facebook_id'] as String?,
      instagramId: json['instagram_id'] as String?,
      twitterId: json['twitter_id'] as String?,
    );
  }
}
