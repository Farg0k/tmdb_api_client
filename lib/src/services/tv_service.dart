import 'base_tmdb_service.dart';
import '../models/media_models.dart';
import '../models/common/media_account_states.dart';
import '../models/common/alternative_title.dart';
import '../models/common/tmdb_external_ids.dart';
import '../models/common/tmdb_list_response.dart';
import '../models/common/tmdb_video.dart';
import '../models/common/tmdb_image.dart';
import '../models/common/tmdb_review.dart';
import '../models/common/tmdb_credit.dart';
import '../models/common/tmdb_watch_provider.dart';
import '../models/tv/tv_details.dart';
import '../models/tv/tv_aggregate_credits.dart';
import '../models/keyword_models.dart';
import '../models/tv/tv_screened_theatrically.dart';
import '../models/tv/tv_content_ratings.dart';

/// [TvService] handles API interactions related to TV series on TMDB.
class TvService extends BaseTmdbService {
  TvService(super.client);

  /// --- TV Series Lists ---

  /// Get a list of TV shows that are airing today.
  Future<TmdbResponsePage<TvSummary>> getAiringToday({
    int? page,
    String? language,
    String? timezone,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      'timezone': ?timezone,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/airing_today', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get a list of TV shows that are currently on the air.
  Future<TmdbResponsePage<TvSummary>> getOnTheAir({
    int? page,
    String? language,
    String? timezone,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      'timezone': ?timezone,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/on_the_air', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get a list of the current popular TV shows on TMDB.
  Future<TmdbResponsePage<TvSummary>> getPopular({
    int? page,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/popular', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get the top rated TV shows on TMDB.
  Future<TmdbResponsePage<TvSummary>> getTopRated({
    int? page,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/top_rated', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// --- TV Series Details & Info ---

  /// Get the primary information about a TV series.
  ///
  /// Supports [appendToResponse] with comma-separated values:
  /// `credits`, `images`, `videos`, `keywords`, `recommendations`,
  /// `similar`, `external_ids`, `content_ratings`, `aggregate_credits`,
  /// `season/{season_number}`, `translations`, `watch/providers`,
  /// `account_states`, `changes`, `alternative_titles`
  Future<TvDetails> getDetails(
    int seriesId, {
    String? language,
    String? appendToResponse,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'append_to_response': ?appendToResponse,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/$seriesId', queryParameters: params);
    return TvDetails.fromJson(jsonResponse);
  }

  /// Get the user rating and status for a specific TV series.
  Future<MediaAccountStates> getAccountStates(
    int seriesId, {
    String? sessionId,
    String? guestSessionId,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'session_id': ?sessionId,
      'guest_session_id': ?guestSessionId,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'tv/$seriesId/account_states',
      queryParameters: params,
    );
    return MediaAccountStates.fromJson(jsonResponse);
  }

  /// Get the aggregate credits for a TV series.
  Future<TvAggregateCredits> getAggregateCredits(
    int seriesId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'tv/$seriesId/aggregate_credits',
      queryParameters: params,
    );
    return TvAggregateCredits.fromJson(jsonResponse);
  }

  /// Get all of the alternative titles for a TV series.
  Future<TmdbListResponse<AlternativeTitle>> getAlternativeTitles(
    int seriesId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'tv/$seriesId/alternative_titles',
      queryParameters: queryParameters,
    );
    return TmdbListResponse.fromJson(
      jsonResponse,
      AlternativeTitle.fromJson,
      resultsKey: 'results',
    );
  }

  /// Get the changes for a TV series.
  Future<Map<String, dynamic>> getChanges(
    int seriesId, {
    String? startDate,
    String? endDate,
    int? page,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'start_date': ?startDate,
      'end_date': ?endDate,
      ...?queryParameters,
    };
    return (await get('tv/$seriesId/changes', queryParameters: params) as Map<String, dynamic>);
  }

  /// Get the list of content ratings for a TV series.
  Future<TmdbListResponse<TvContentRating>> getContentRatings(
    int seriesId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'tv/$seriesId/content_ratings',
      queryParameters: queryParameters,
    );
    return TmdbListResponse.fromJson(jsonResponse, TvContentRating.fromJson);
  }

  /// Get the cast and crew for a TV series.
  Future<TmdbCredits> getCredits(
    int seriesId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'tv/$seriesId/credits',
      queryParameters: params,
    );
    return TmdbCredits.fromJson(jsonResponse);
  }

  /// Get all of the episode groups for a TV series.
  Future<TmdbListResponse<Map<String, dynamic>>> getEpisodeGroups(
    int seriesId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'tv/$seriesId/episode_groups',
      queryParameters: queryParameters,
    );
    return TmdbListResponse.fromJson(jsonResponse, (i) => i);
  }

  /// Get the external ids for a TV series.
  Future<TmdbExternalIds> getExternalIds(
    int seriesId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'tv/$seriesId/external_ids',
      queryParameters: queryParameters,
    );
    return TmdbExternalIds.fromJson(jsonResponse);
  }

  /// Get the images for a TV series.
  Future<TmdbImagesResponse> getImages(
    int seriesId, {
    String? language,
    String? includeImageLanguage,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'include_image_language': ?includeImageLanguage,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'tv/$seriesId/images',
      queryParameters: params,
    );
    return TmdbImagesResponse.fromJson(jsonResponse);
  }

  /// Get the keywords for a TV series.
  Future<TmdbListResponse<Keyword>> getKeywords(
    int seriesId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'tv/$seriesId/keywords',
      queryParameters: queryParameters,
    );
    return TmdbListResponse.fromJson(jsonResponse, Keyword.fromJson);
  }

  /// Get the most newly created TV series ID.
  Future<TvDetails> getLatest({
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get('tv/latest', queryParameters: params);
    return TvDetails.fromJson(jsonResponse);
  }

  /// Get the lists that a TV series has been added to.
  Future<TmdbResponsePage<Map<String, dynamic>>> getLists(
    int seriesId, {
    int? page,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'tv/$seriesId/lists',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, (i) => i);
  }

  /// Get a list of recommended TV series.
  Future<TmdbResponsePage<TvSummary>> getRecommendations(
    int seriesId, {
    int? page,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'tv/$seriesId/recommendations',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get the user reviews for a TV series.
  Future<TmdbResponsePage<TmdbReview>> getReviews(
    int seriesId, {
    int? page,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'tv/$seriesId/reviews',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, TmdbReview.fromJson);
  }

  /// Get theatrical screenings info.
  Future<TvScreenedTheatricallyResponse> getScreenedTheatrically(
    int seriesId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'tv/$seriesId/screened_theatrically',
      queryParameters: queryParameters,
    );
    return TvScreenedTheatricallyResponse.fromJson(jsonResponse);
  }

  /// Get a list of similar TV series.
  Future<TmdbResponsePage<TvSummary>> getSimilar(
    int seriesId, {
    int? page,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'tv/$seriesId/similar',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get the translations for a TV series.
  Future<TmdbListResponse<Map<String, dynamic>>> getTranslations(
    int seriesId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'tv/$seriesId/translations',
      queryParameters: queryParameters,
    );
    return TmdbListResponse.fromJson(
      jsonResponse,
      (i) => i,
      resultsKey: 'translations',
    );
  }

  /// Get the videos for a TV series.
  Future<TmdbListResponse<TmdbVideo>> getVideos(
    int seriesId, {
    String? language,
    String? includeVideoLanguage,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'include_video_language': ?includeVideoLanguage,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'tv/$seriesId/videos',
      queryParameters: params,
    );
    return TmdbListResponse.fromJson(jsonResponse, TmdbVideo.fromJson);
  }

  /// Get the watch providers for a TV series.
  Future<TmdbWatchProvidersResponse> getWatchProviders(
    int seriesId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'tv/$seriesId/watch/providers',
      queryParameters: queryParameters,
    );
    return TmdbWatchProvidersResponse.fromJson(jsonResponse);
  }

  /// Rate a TV series.
  Future<bool> addRating(
    int seriesId,
    double rating, {
    String? sessionId,
    String? guestSessionId,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'session_id': ?sessionId,
      'guest_session_id': ?guestSessionId,
      ...?queryParameters,
    };
    final jsonResponse = await post(
      'tv/$seriesId/rating',
      body: {'value': rating},
      queryParameters: params,
    );
    return jsonResponse['success'] == true;
  }

  /// Delete a rating.
  Future<bool> deleteRating(
    int seriesId, {
    String? sessionId,
    String? guestSessionId,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'session_id': ?sessionId,
      'guest_session_id': ?guestSessionId,
      ...?queryParameters,
    };
    final jsonResponse = await delete(
      'tv/$seriesId/rating',
      queryParameters: params,
    );
    return jsonResponse['success'] == true;
  }
}
