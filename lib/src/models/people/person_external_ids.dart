/// [PersonExternalIds] contains IDs for other databases and social media for a person.
class PersonExternalIds {
  final int id;
  final String? imdbId;
  final String? wikidataId;
  final String? facebookId;
  final String? instagramId;
  final String? tiktokId;
  final String? twitterId;
  final String? youtubeId;

  PersonExternalIds({
    required this.id,
    this.imdbId,
    this.wikidataId,
    this.facebookId,
    this.instagramId,
    this.tiktokId,
    this.twitterId,
    this.youtubeId,
  });

  factory PersonExternalIds.fromJson(Map<String, dynamic> json) {
    return PersonExternalIds(
      id: json['id'] as int,
      imdbId: json['imdb_id'] as String?,
      wikidataId: json['wikidata_id'] as String?,
      facebookId: json['facebook_id'] as String?,
      instagramId: json['instagram_id'] as String?,
      tiktokId: json['tiktok_id'] as String?,
      twitterId: json['twitter_id'] as String?,
      youtubeId: json['youtube_id'] as String?,
    );
  }
}
