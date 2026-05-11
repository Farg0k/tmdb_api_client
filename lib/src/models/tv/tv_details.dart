import '../genre_models.dart';
import '../media_models.dart';
import '../common/tmdb_company.dart';
import '../common/tmdb_country.dart';
import '../common/tmdb_language.dart';
import '../common/tmdb_credit.dart';
import '../common/tmdb_business_details.dart';
import '../common/tmdb_image.dart';
import '../common/tmdb_video.dart';
import '../common/tmdb_list_response.dart';
import '../common/tmdb_external_ids.dart';
import '../common/tmdb_watch_provider.dart';
import '../common/media_account_states.dart';
import '../common/alternative_title.dart';
import '../keyword_models.dart';
import 'tv_episode_summary.dart';
import 'tv_season_summary.dart';
import 'seasons/tv_season_details.dart';
import 'tv_content_ratings.dart';
import 'tv_aggregate_credits.dart';

/// [TvDetails] represents the full information about a TV series.
class TvDetails {
  final bool adult;
  final String? backdropPath;
  final List<TmdbCast> createdBy; // Replaced TvCreator with TmdbCast
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String? lastAirDate;
  final TvEpisodeSummary? lastEpisodeToAir;
  final String name;
  final TvEpisodeSummary? nextEpisodeToAir;
  final List<TmdbBusinessDetails> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<TmdbCompany> productionCompanies;
  final List<TmdbCountry> productionCountries;
  final List<TvSeasonSummary> seasons;
  final List<TmdbLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

   // Appended resources (optional)
   final TmdbCredits? credits;
   final TmdbImagesResponse? images;
   final TmdbListResponse<TmdbVideo>? videos;
   final TmdbListResponse<Keyword>? keywords;
   final TmdbResponsePage<TvSummary>? recommendations;
   final TmdbResponsePage<TvSummary>? similar;
   final TmdbExternalIds? externalIds;
   final List<TvContentRating>? contentRatings;
   final TvAggregateCredits? aggregateCredits;
   final TmdbListResponse<AlternativeTitle>? alternativeTitles;
   final Map<int, TvSeasonDetails>? appendedSeasons;
   final Map<String, dynamic>? translations;
   final TmdbWatchProvidersResponse? watchProviders;
   final MediaAccountStates? accountStates;
   final Map<String, dynamic>? changes;

  TvDetails({
    required this.adult,
    this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    required this.name,
    this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
    this.credits,
    this.images,
    this.videos,
    this.keywords,
    this.recommendations,
    this.similar,
    this.externalIds,
    this.contentRatings,
    this.aggregateCredits,
    this.alternativeTitles,
    this.appendedSeasons,
    this.translations,
    this.watchProviders,
    this.accountStates,
    this.changes,
  });

  factory TvDetails.fromJson(Map<String, dynamic> json) {
    // Parse appended seasons (keys like "season/1", "season/2")
    final Map<int, TvSeasonDetails> seasonsMap = {};
    json.forEach((key, value) {
      if (key.startsWith('season/')) {
        final seasonNum = int.tryParse(key.substring(7));
        if (seasonNum != null && value is Map<String, dynamic>) {
          seasonsMap[seasonNum] = TvSeasonDetails.fromJson(value);
        }
      }
    });

    // Parse content ratings if present (has 'results' array)
    final List<TvContentRating>? contentRatingsList = json['content_ratings'] != null
        ? (json['content_ratings'] as Map<String, dynamic>)['results']
                ?.map((e) => TvContentRating.fromJson(e as Map<String, dynamic>))
                .toList()
        : null;

    return TvDetails(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      createdBy:
          (json['created_by'] as List?)
              ?.map((i) => TmdbCast.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      episodeRunTime:
          (json['episode_run_time'] as List?)?.map((e) => e as int).toList() ??
          [],
      firstAirDate: json['first_air_date'] as String? ?? '',
      genres:
          (json['genres'] as List?)
              ?.map((i) => Genre.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      homepage: json['homepage'] as String? ?? '',
      id: json['id'] as int,
      inProduction: json['in_production'] as bool? ?? false,
      languages:
          (json['languages'] as List?)?.map((e) => e as String).toList() ?? [],
      lastAirDate: json['last_air_date'] as String?,
      lastEpisodeToAir: json['last_episode_to_air'] != null
          ? TvEpisodeSummary.fromJson(
              json['last_episode_to_air'] as Map<String, dynamic>,
            )
          : null,
      name: json['name'] as String? ?? '',
      nextEpisodeToAir: json['next_episode_to_air'] != null
          ? TvEpisodeSummary.fromJson(
              json['next_episode_to_air'] as Map<String, dynamic>,
            )
          : null,
      networks:
          (json['networks'] as List?)
              ?.map(
                (i) => TmdbBusinessDetails.fromJson(i as Map<String, dynamic>),
              )
              .toList() ??
          [],
      numberOfEpisodes: json['number_of_episodes'] as int? ?? 0,
      numberOfSeasons: json['number_of_seasons'] as int? ?? 0,
      originCountry:
          (json['origin_country'] as List?)?.map((e) => e as String).toList() ??
          [],
      originalLanguage: json['original_language'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] as String?,
      productionCompanies:
          (json['production_companies'] as List?)
              ?.map((i) => TmdbCompany.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      productionCountries:
          (json['production_countries'] as List?)
              ?.map((i) => TmdbCountry.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      seasons:
          (json['seasons'] as List?)
              ?.map((i) => TvSeasonSummary.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      spokenLanguages:
          (json['spoken_languages'] as List?)
              ?.map((i) => TmdbLanguage.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      type: json['type'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
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
      keywords: json['keywords'] != null
          ? TmdbListResponse.fromJson(
              json['keywords'] as Map<String, dynamic>,
              Keyword.fromJson,
              resultsKey: 'keywords',
            )
          : null,
      recommendations: json['recommendations'] != null
          ? TmdbResponsePage.fromJson(
              json['recommendations'] as Map<String, dynamic>,
              TvSummary.fromJson,
            )
          : null,
      similar: json['similar'] != null
          ? TmdbResponsePage.fromJson(
              json['similar'] as Map<String, dynamic>,
              TvSummary.fromJson,
            )
          : null,
      externalIds: json['external_ids'] != null
          ? TmdbExternalIds.fromJson(
              json['external_ids'] as Map<String, dynamic>,
            )
          : null,
      contentRatings: contentRatingsList,
      aggregateCredits: json['aggregate_credits'] != null
          ? TvAggregateCredits.fromJson(
              json['aggregate_credits'] as Map<String, dynamic>,
            )
          : null,
      alternativeTitles: json['alternative_titles'] != null
          ? TmdbListResponse.fromJson(
              json['alternative_titles'] as Map<String, dynamic>,
              AlternativeTitle.fromJson,
              resultsKey: 'titles',
            )
          : null,
      appendedSeasons: seasonsMap.isNotEmpty ? seasonsMap : null,
      translations: json['translations'] as Map<String, dynamic>?,
      watchProviders: json['watch/providers'] != null
          ? TmdbWatchProvidersResponse.fromJson(
              json['watch/providers'] as Map<String, dynamic>,
            )
          : null,
      accountStates: json['account_states'] != null
          ? MediaAccountStates.fromJson(
              json['account_states'] as Map<String, dynamic>,
            )
          : null,
      changes: json['changes'] as Map<String, dynamic>?,
    );
  }
}
