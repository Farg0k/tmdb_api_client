import 'base_tmdb_service.dart';
import '../models/media_models.dart';
import '../models/tv/tv_details.dart';
import '../models/tv/tv_account_states.dart';
import '../models/tv/tv_aggregate_credits.dart';
import '../models/tv/tv_alternative_titles.dart';
import '../models/tv/tv_content_ratings.dart';
import '../models/tv/tv_credits.dart';
import '../models/tv/tv_episode_groups.dart';
import '../models/tv/tv_external_ids.dart';
import '../models/tv/tv_images.dart';
import '../models/tv/tv_keywords.dart';
import '../models/tv/tv_reviews.dart';
import '../models/tv/tv_screened_theatrically.dart';
import '../models/tv/tv_translations.dart';
import '../models/tv/tv_videos.dart';
import '../models/tv/tv_watch_providers.dart';

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
  Future<TvAccountStates> getAccountStates(
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
    final jsonResponse = await get('tv/$seriesId/account_states', queryParameters: params);
    return TvAccountStates.fromJson(jsonResponse);
  }

  /// Get the aggregate credits (cast and crew) for a TV series.
  Future<TvAggregateCredits> getAggregateCredits(
    int seriesId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/$seriesId/aggregate_credits', queryParameters: params);
    return TvAggregateCredits.fromJson(jsonResponse);
  }

  /// Get all of the alternative titles for a TV series.
  Future<TvAlternativeTitlesResponse> getAlternativeTitles(int seriesId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('tv/$seriesId/alternative_titles', queryParameters: queryParameters);
    return TvAlternativeTitlesResponse.fromJson(jsonResponse);
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
    return get('tv/$seriesId/changes', queryParameters: params);
  }

  /// Get the list of content ratings (age ratings) for a TV series.
  Future<TvContentRatingsResponse> getContentRatings(int seriesId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('tv/$seriesId/content_ratings', queryParameters: queryParameters);
    return TvContentRatingsResponse.fromJson(jsonResponse);
  }

  /// Get the cast and crew for a TV series.
  Future<TvCredits> getCredits(
    int seriesId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/$seriesId/credits', queryParameters: params);
    return TvCredits.fromJson(jsonResponse);
  }

  /// Get all of the episode groups that have been created for a TV series.
  Future<TvEpisodeGroupsResponse> getEpisodeGroups(int seriesId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('tv/$seriesId/episode_groups', queryParameters: queryParameters);
    return TvEpisodeGroupsResponse.fromJson(jsonResponse);
  }

  /// Get the external ids for a TV series.
  Future<TvExternalIds> getExternalIds(int seriesId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('tv/$seriesId/external_ids', queryParameters: queryParameters);
    return TvExternalIds.fromJson(jsonResponse);
  }

  /// Get the images that belong to a TV series.
  Future<TvImagesResponse> getImages(
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
    final jsonResponse = await get('tv/$seriesId/images', queryParameters: params);
    return TvImagesResponse.fromJson(jsonResponse);
  }

  /// Get the keywords that have been added to a TV series.
  Future<TvKeywordsResponse> getKeywords(int seriesId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('tv/$seriesId/keywords', queryParameters: queryParameters);
    return TvKeywordsResponse.fromJson(jsonResponse);
  }

  /// Get the most newly created TV series ID.
  Future<TvDetails> getLatest({
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
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
    final jsonResponse = await get('tv/$seriesId/lists', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, (i) => i);
  }

  /// Get a list of recommended TV series for a TV series.
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
    final jsonResponse = await get('tv/$seriesId/recommendations', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get the user reviews for a TV series.
  Future<TvReviewsResponse> getReviews(
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
    final jsonResponse = await get('tv/$seriesId/reviews', queryParameters: params);
    return TvReviewsResponse.fromJson(jsonResponse);
  }

  /// Get a list of episodes that have been screened theatrically.
  Future<TvScreenedTheatricallyResponse> getScreenedTheatrically(int seriesId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('tv/$seriesId/screened_theatrically', queryParameters: queryParameters);
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
    final jsonResponse = await get('tv/$seriesId/similar', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get a list of translations that have been created for a TV series.
  Future<TvTranslationsResponse> getTranslations(int seriesId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('tv/$seriesId/translations', queryParameters: queryParameters);
    return TvTranslationsResponse.fromJson(jsonResponse);
  }

  /// Get the videos that have been added to a TV series.
  Future<TvVideosResponse> getVideos(
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
    final jsonResponse = await get('tv/$seriesId/videos', queryParameters: params);
    return TvVideosResponse.fromJson(jsonResponse);
  }

  /// Get a list of watch providers for a TV series.
  Future<TvWatchProvidersResponse> getWatchProviders(int seriesId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('tv/$seriesId/watch/providers', queryParameters: queryParameters);
    return TvWatchProvidersResponse.fromJson(jsonResponse);
  }

  /// --- TV Series Actions ---

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

  /// Delete a rating for a TV series.
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
    final jsonResponse = await delete('tv/$seriesId/rating', queryParameters: params);
    return jsonResponse['success'] == true;
  }
}
