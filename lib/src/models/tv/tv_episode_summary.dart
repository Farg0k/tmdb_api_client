import '../common/tmdb_credit.dart';
import '../common/tmdb_image.dart';
import '../common/tmdb_video.dart';
import '../common/tmdb_list_response.dart';
import '../common/tmdb_external_ids.dart';

/// [TvEpisodeSummary] represents a concise version of TV episode data.
class TvEpisodeSummary {
  final String? airDate;
  final int episodeNumber;
  final String episodeType;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;
  final List<TmdbCrew>? crew;
  final List<TmdbCast>? guestStars;
  final int? order; // Added for Episode Groups
  final double? rating; // Added for Rated Episode Summary support

  // Appended resources (optional)
  final TmdbCredits? credits;
  final TmdbImagesResponse? images;
  final TmdbListResponse<TmdbVideo>? videos;
  final TmdbExternalIds? externalIds;

  TvEpisodeSummary({
    this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    this.runtime,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    this.crew,
    this.guestStars,
    this.order,
    this.rating,
    this.credits,
    this.images,
    this.videos,
    this.externalIds,
  });

  factory TvEpisodeSummary.fromJson(Map<String, dynamic> json) {
    return TvEpisodeSummary(
      airDate: json['air_date'] as String?,
      episodeNumber: json['episode_number'] as int? ?? 0,
      episodeType: json['episode_type'] as String? ?? '',
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      productionCode: json['production_code'] as String? ?? '',
      runtime: json['runtime'] as int?,
      seasonNumber: json['season_number'] as int? ?? 0,
      showId: json['show_id'] as int? ?? 0,
      stillPath: json['still_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      crew: (json['crew'] as List?)
          ?.map((i) => TmdbCrew.fromJson(i as Map<String, dynamic>))
          .toList(),
      guestStars: (json['guest_stars'] as List?)
          ?.map((i) => TmdbCast.fromJson(i as Map<String, dynamic>))
          .toList(),
      order: json['order'] as int?,
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      // Appended resources
      credits: json['credits'] != null
          ? TmdbCredits.fromJson(json['credits'] as Map<String, dynamic>)
          : null,
      images: json['images'] != null
          ? TmdbImagesResponse.fromJson(
              json['images'] as Map<String, dynamic>,
            )
          : null,
      videos: json['videos'] != null
          ? TmdbListResponse.fromJson(
              json['videos'] as Map<String, dynamic>,
              TmdbVideo.fromJson,
              resultsKey: 'results',
            )
          : null,
      externalIds: json['external_ids'] != null
          ? TmdbExternalIds.fromJson(
              json['external_ids'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}
