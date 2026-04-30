import 'media_models.dart';

/// [FindResponse] contains the results of a find by external ID request.
/// TMDB returns results grouped by media type.
class FindResponse {
  final List<MovieSummary> movieResults;
  final List<TvSummary> tvResults;
  final List<dynamic> tvEpisodeResults;
  final List<dynamic> tvSeasonResults;
  final List<dynamic> personResults;

  FindResponse({
    required this.movieResults,
    required this.tvResults,
    required this.tvEpisodeResults,
    required this.tvSeasonResults,
    required this.personResults,
  });

  factory FindResponse.fromJson(Map<String, dynamic> json) {
    return FindResponse(
      movieResults: (json['movie_results'] as List?)
              ?.map((i) => MovieSummary.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      tvResults: (json['tv_results'] as List?)
              ?.map((i) => TvSummary.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      tvEpisodeResults: json['tv_episode_results'] as List? ?? [],
      tvSeasonResults: json['tv_season_results'] as List? ?? [],
      personResults: json['person_results'] as List? ?? [],
    );
  }
}

/// [ExternalSource] defines the supported external ID sources for the find endpoint.
enum ExternalSource {
  imdbId,
  freebaseMid,
  freebaseId,
  tvdbId,
  tvrageId,
  facebookId,
  instagramId,
  twitterId,
}

extension ExternalSourceExtension on ExternalSource {
  String get value {
    switch (this) {
      case ExternalSource.imdbId:
        return 'imdb_id';
      case ExternalSource.freebaseMid:
        return 'freebase_mid';
      case ExternalSource.freebaseId:
        return 'freebase_id';
      case ExternalSource.tvdbId:
        return 'tvdb_id';
      case ExternalSource.tvrageId:
        return 'tvrage_id';
      case ExternalSource.facebookId:
        return 'facebook_id';
      case ExternalSource.instagramId:
        return 'instagram_id';
      case ExternalSource.twitterId:
        return 'twitter_id';
    }
  }
}
