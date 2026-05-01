import '../tv_episode_summary.dart';
import '../../networks/network_details.dart';

/// [TvEpisodeGroupDetails] represents the full information about a TV episode group.
class TvEpisodeGroupDetails {
  final String? description;
  final int episodeCount;
  final int groupCount;
  final String id;
  final String name;
  final NetworkDetails? network;
  final int type;
  final List<TvEpisodeGroup> groups;

  TvEpisodeGroupDetails({
    this.description,
    required this.episodeCount,
    required this.groupCount,
    required this.id,
    required this.name,
    this.network,
    required this.type,
    required this.groups,
  });

  factory TvEpisodeGroupDetails.fromJson(Map<String, dynamic> json) {
    return TvEpisodeGroupDetails(
      description: json['description'] as String?,
      episodeCount: json['episode_count'] as int? ?? 0,
      groupCount: json['group_count'] as int? ?? 0,
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      network: json['network'] != null ? NetworkDetails.fromJson(json['network'] as Map<String, dynamic>) : null,
      type: json['type'] as int? ?? 0,
      groups: (json['groups'] as List?)
              ?.map((i) => TvEpisodeGroup.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class TvEpisodeGroup {
  final String id;
  final String name;
  final int order;
  final List<TvEpisodeSummary> episodes;
  final bool locked;

  TvEpisodeGroup({
    required this.id,
    required this.name,
    required this.order,
    required this.episodes,
    required this.locked,
  });

  factory TvEpisodeGroup.fromJson(Map<String, dynamic> json) {
    return TvEpisodeGroup(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      episodes: (json['episodes'] as List?)
              ?.map((i) => TvEpisodeSummary.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      locked: json['locked'] as bool? ?? false,
    );
  }
}
