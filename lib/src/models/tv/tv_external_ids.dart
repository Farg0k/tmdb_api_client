class TvExternalIds {
  final int id;
  final String? imdbId;
  final String? freebaseMid;
  final String? freebaseId;
  final String? tvdbId;
  final String? tvrageId;
  final String? wikidataId;
  final String? facebookId;
  final String? instagramId;
  final String? twitterId;

  TvExternalIds({
    required this.id,
    this.imdbId,
    this.freebaseMid,
    this.freebaseId,
    this.tvdbId,
    this.tvrageId,
    this.wikidataId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
  });

  factory TvExternalIds.fromJson(Map<String, dynamic> json) {
    return TvExternalIds(
      id: json['id'] as int,
      imdbId: json['imdb_id'] as String?,
      freebaseMid: json['freebase_mid'] as String?,
      freebaseId: json['freebase_id'] as String?,
      tvdbId: json['tvdb_id']?.toString(),
      tvrageId: json['tvrage_id']?.toString(),
      wikidataId: json['wikidata_id'] as String?,
      facebookId: json['facebook_id'] as String?,
      instagramId: json['instagram_id'] as String?,
      twitterId: json['twitter_id'] as String?,
    );
  }
}
