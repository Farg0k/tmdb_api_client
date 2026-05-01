import 'base_tmdb_service.dart';
import '../models/tv/seasons/tv_season_details.dart';
import '../models/tv/seasons/tv_season_account_states.dart';
import '../models/tv/seasons/tv_season_external_ids.dart';
import '../models/tv/tv_credits.dart';
import '../models/tv/tv_aggregate_credits.dart';
import '../models/tv/tv_images.dart';
import '../models/tv/tv_videos.dart';
import '../models/tv/tv_translations.dart';
import '../models/tv/tv_watch_providers.dart';

/// [TvSeasonsService] handles API interactions related to TV seasons on TMDB.
class TvSeasonsService extends BaseTmdbService {
  TvSeasonsService(super.client);

  /// Get the details of a TV season.
  Future<TvSeasonDetails> getDetails(
    int seriesId,
    int seasonNumber, {
    String? language,
    String? appendToResponse,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'append_to_response': ?appendToResponse,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber', queryParameters: params);
    return TvSeasonDetails.fromJson(jsonResponse);
  }

  /// Get the user rating status for all episodes in a season.
  Future<TvSeasonAccountStates> getAccountStates(
    int seriesId,
    int seasonNumber, {
    String? sessionId,
    String? guestSessionId,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'session_id': ?sessionId,
      'guest_session_id': ?guestSessionId,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/account_states', queryParameters: params);
    return TvSeasonAccountStates.fromJson(jsonResponse);
  }

  /// Get the aggregate credits for a TV season.
  Future<TvAggregateCredits> getAggregateCredits(
    int seriesId,
    int seasonNumber, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/aggregate_credits', queryParameters: params);
    return TvAggregateCredits.fromJson(jsonResponse);
  }

  /// Get the changes for a TV season.
  Future<Map<String, dynamic>> getChanges(
    int seasonId, {
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
    return get('tv/season/$seasonId/changes', queryParameters: params);
  }

  /// Get the credits (cast and crew) for a TV season.
  Future<TvCredits> getCredits(
    int seriesId,
    int seasonNumber, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/credits', queryParameters: params);
    return TvCredits.fromJson(jsonResponse);
  }

  /// Get the external ids for a TV season.
  Future<TvSeasonExternalIds> getExternalIds(int seriesId, int seasonNumber, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/external_ids', queryParameters: queryParameters);
    return TvSeasonExternalIds.fromJson(jsonResponse);
  }

  /// Get the images that belong to a TV season.
  Future<TvImagesResponse> getImages(
    int seriesId,
    int seasonNumber, {
    String? language,
    String? includeImageLanguage,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'include_image_language': ?includeImageLanguage,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/images', queryParameters: params);
    return TvImagesResponse.fromJson(jsonResponse);
  }

  /// Get the translations for a TV season.
  Future<TvTranslationsResponse> getTranslations(int seriesId, int seasonNumber, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/translations', queryParameters: queryParameters);
    return TvTranslationsResponse.fromJson(jsonResponse);
  }

  /// Get the videos that have been added to a TV season.
  Future<TvVideosResponse> getVideos(
    int seriesId,
    int seasonNumber, {
    String? language,
    String? includeVideoLanguage,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'include_video_language': ?includeVideoLanguage,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/videos', queryParameters: params);
    return TvVideosResponse.fromJson(jsonResponse);
  }

  /// Get a list of watch providers for a TV season.
  Future<TvWatchProvidersResponse> getWatchProviders(
    int seriesId,
    int seasonNumber, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/watch/providers', queryParameters: params);
    return TvWatchProvidersResponse.fromJson(jsonResponse);
  }
}
