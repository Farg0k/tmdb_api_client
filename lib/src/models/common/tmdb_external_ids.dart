/// [TmdbExternalIds] contains IDs for other databases and social media platforms.
/// This is a unified model for Movies, TV Series, Seasons, Episodes, and People.
class TmdbExternalIds {
  final int id;
  final String? imdbId;
  final String? facebookId;
  final String? instagramId;
  final String? twitterId;
  final String? tiktokId;
  final String? youtubeId;
  final String? wikidataId;
  final String? tvdbId;
  final String? tvrageId;
  final String? freebaseMid;
  final String? freebaseId;

  TmdbExternalIds({
    required this.id,
    this.imdbId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
    this.tiktokId,
    this.youtubeId,
    this.wikidataId,
    this.tvdbId,
    this.tvrageId,
    this.freebaseMid,
    this.freebaseId,
  });

  factory TmdbExternalIds.fromJson(Map<String, dynamic> json) {
    return TmdbExternalIds(
      id: json['id'] as int? ?? 0,
      imdbId: json['imdb_id'] as String?,
      facebookId: json['facebook_id'] as String?,
      instagramId: json['instagram_id'] as String?,
      twitterId: json['twitter_id'] as String?,
      tiktokId: json['tiktok_id'] as String?,
      youtubeId: json['youtube_id'] as String?,
      wikidataId: json['wikidata_id'] as String?,
      tvdbId: json['tvdb_id']?.toString(),
      tvrageId: json['tvrage_id']?.toString(),
      freebaseMid: json['freebase_mid'] as String?,
      freebaseId: json['freebase_id'] as String?,
    );
  }

  @override
  String toString() {
    return '''
    TmdbExternalIds{
      id: $id, 
      imdbId: $imdbId, 
      facebookId: $facebookId, 
      instagramId: $instagramId, 
      twitterId: $twitterId, 
      tiktokId: $tiktokId, 
      youtubeId: $youtubeId, 
      wikidataId: $wikidataId, 
      tvdbId: $tvdbId, 
      tvrageId: $tvrageId, 
      freebaseMid: $freebaseMid, 
      freebaseId: $freebaseId
    }''';
  }
}
