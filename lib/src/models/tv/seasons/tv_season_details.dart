import '../tv_episode_summary.dart';

/// [TvSeasonDetails] represents the full information about a TV season.
class TvSeasonDetails {
  final String? airDate;
  final List<TvEpisodeSummary> episodes;
  final String name;
  final String overview;
  final int id;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  TvSeasonDetails({
    this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory TvSeasonDetails.fromJson(Map<String, dynamic> json) {
    return TvSeasonDetails(
      airDate: json['air_date'] as String?,
      episodes:
          (json['episodes'] as List?)
              ?.map((i) => TvEpisodeSummary.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      id: json['id'] as int,
      posterPath: json['poster_path'] as String?,
      seasonNumber: json['season_number'] as int? ?? 0,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
