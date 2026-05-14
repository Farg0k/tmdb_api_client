import '../tv_episode_summary.dart';
import '../../common/tmdb_credit.dart';
import '../../common/tmdb_image.dart';
import '../../common/tmdb_video.dart';
import '../../common/tmdb_list_response.dart';
import '../tv_aggregate_credits.dart';

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

  // Appended resources (optional)
  final TmdbCredits? credits;
  final TmdbImagesResponse? images;
  final TmdbListResponse<TmdbVideo>? videos;
  final TvAggregateCredits? aggregateCredits;

  TvSeasonDetails({
    this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
    this.credits,
    this.images,
    this.videos,
    this.aggregateCredits,
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
      // Appended resources
      credits: json['credits'] != null
          ? TmdbCredits.fromJson(json['credits'] as Map<String, dynamic>)
          : null,
      images: json['images'] != null
          ? TmdbImagesResponse.fromJson(json['images'] as Map<String, dynamic>)
          : null,
      videos: json['videos'] != null
          ? TmdbListResponse.fromJson(
              json['videos'] as Map<String, dynamic>,
              TmdbVideo.fromJson,
              resultsKey: 'results',
            )
          : null,
      aggregateCredits: json['aggregate_credits'] != null
          ? TvAggregateCredits.fromJson(
              json['aggregate_credits'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}
