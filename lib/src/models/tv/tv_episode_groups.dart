class TvEpisodeGroupSummary {
  final String? description;
  final int episodeCount;
  final int groupCount;
  final String id;
  final String name;
  final dynamic network;
  final int type;

  TvEpisodeGroupSummary({
    this.description,
    required this.episodeCount,
    required this.groupCount,
    required this.id,
    required this.name,
    this.network,
    required this.type,
  });

  factory TvEpisodeGroupSummary.fromJson(Map<String, dynamic> json) {
    return TvEpisodeGroupSummary(
      description: json['description'] as String?,
      episodeCount: json['episode_count'] as int? ?? 0,
      groupCount: json['group_count'] as int? ?? 0,
      id: json['id'] as String,
      name: json['name'] as String,
      network: json['network'],
      type: json['type'] as int? ?? 0,
    );
  }
}

class TvEpisodeGroupsResponse {
  final int id;
  final List<TvEpisodeGroupSummary> results;

  TvEpisodeGroupsResponse({required this.id, required this.results});

  factory TvEpisodeGroupsResponse.fromJson(Map<String, dynamic> json) {
    return TvEpisodeGroupsResponse(
      id: json['id'] as int,
      results: (json['results'] as List)
          .map((i) => TvEpisodeGroupSummary.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
