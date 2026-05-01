/// [TvSeasonExternalIds] contains IDs for other databases for a TV season.
class TvSeasonExternalIds {
  final int id;
  final String? freebaseMid;
  final String? freebaseId;
  final String? tvdbId;
  final String? tvrageId;
  final String? wikidataId;

  TvSeasonExternalIds({
    required this.id,
    this.freebaseMid,
    this.freebaseId,
    this.tvdbId,
    this.tvrageId,
    this.wikidataId,
  });

  factory TvSeasonExternalIds.fromJson(Map<String, dynamic> json) {
    return TvSeasonExternalIds(
      id: json['id'] as int,
      freebaseMid: json['freebase_mid'] as String?,
      freebaseId: json['freebase_id'] as String?,
      tvdbId: json['tvdb_id']?.toString(),
      tvrageId: json['tvrage_id']?.toString(),
      wikidataId: json['wikidata_id'] as String?,
    );
  }
}
