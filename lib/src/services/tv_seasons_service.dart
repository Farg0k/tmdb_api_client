import 'base_tmdb_service.dart';
import '../models/common/media_account_states.dart';
import '../models/common/tmdb_external_ids.dart';
import '../models/common/tmdb_list_response.dart';
import '../models/common/tmdb_image.dart';
import '../models/common/tmdb_video.dart';
import '../models/common/tmdb_credit.dart';
import '../models/common/tmdb_watch_provider.dart';
import '../models/tv/seasons/tv_season_details.dart';
import '../models/tv/tv_aggregate_credits.dart';

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
    final jsonResponse = await get(
      'tv/$seriesId/season/$seasonNumber',
      queryParameters: params,
    );
    return TvSeasonDetails.fromJson(jsonResponse);
  }

  /// Get the user rating status for all episodes in a season.
  Future<TmdbListResponse<MediaAccountStates>> getAccountStates(
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
    final jsonResponse = await get(
      'tv/$seriesId/season/$seasonNumber/account_states',
      queryParameters: params,
    );
    return TmdbListResponse.fromJson(jsonResponse, MediaAccountStates.fromJson);
  }

  /// Get the aggregate credits for a TV season.
  Future<TvAggregateCredits> getAggregateCredits(
    int seriesId,
    int seasonNumber, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'tv/$seriesId/season/$seasonNumber/aggregate_credits',
      queryParameters: params,
    );
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
    return (await get('tv/season/$seasonId/changes', queryParameters: params) as Map<String, dynamic>);
  }

  /// Get the credits for a TV season.
  Future<TmdbCredits> getCredits(
    int seriesId,
    int seasonNumber, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'tv/$seriesId/season/$seasonNumber/credits',
      queryParameters: params,
    );
    return TmdbCredits.fromJson(jsonResponse);
  }

  /// Get the external ids for a TV season.
  Future<TmdbExternalIds> getExternalIds(
    int seriesId,
    int seasonNumber, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'tv/$seriesId/season/$seasonNumber/external_ids',
      queryParameters: queryParameters,
    );
    return TmdbExternalIds.fromJson(jsonResponse);
  }

  /// Get the images for a TV season.
  Future<TmdbImagesResponse> getImages(
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
    final jsonResponse = await get(
      'tv/$seriesId/season/$seasonNumber/images',
      queryParameters: params,
    );
    return TmdbImagesResponse.fromJson(jsonResponse);
  }

  /// Get the translations for a TV season.
  Future<TmdbListResponse<Map<String, dynamic>>> getTranslations(
    int seriesId,
    int seasonNumber, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'tv/$seriesId/season/$seasonNumber/translations',
      queryParameters: queryParameters,
    );
    return TmdbListResponse.fromJson(
      jsonResponse,
      (i) => i,
      resultsKey: 'translations',
    );
  }

  /// Get the videos for a TV season.
  Future<TmdbListResponse<TmdbVideo>> getVideos(
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
    final jsonResponse = await get(
      'tv/$seriesId/season/$seasonNumber/videos',
      queryParameters: params,
    );
    return TmdbListResponse.fromJson(jsonResponse, TmdbVideo.fromJson);
  }

  /// Get the watch providers for a TV season.
  Future<TmdbWatchProvidersResponse> getWatchProviders(
    int seriesId,
    int seasonNumber, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'tv/$seriesId/season/$seasonNumber/watch/providers',
      queryParameters: params,
    );
    return TmdbWatchProvidersResponse.fromJson(jsonResponse);
  }
}
