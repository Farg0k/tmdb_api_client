import 'base_tmdb_service.dart';
import '../models/tv/tv_episode_summary.dart';
import '../models/common/media_account_states.dart';
import '../models/common/tmdb_external_ids.dart';
import '../models/common/tmdb_list_response.dart';
import '../models/common/tmdb_video.dart';
import '../models/common/tmdb_image.dart';
import '../models/common/tmdb_credit.dart';

/// [TvEpisodesService] handles API interactions related to TV episodes on TMDB.
class TvEpisodesService extends BaseTmdbService {
  TvEpisodesService(super.client);

  /// Get the details of a TV episode.
  Future<TvEpisodeSummary> getDetails(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
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
      'tv/$seriesId/season/$seasonNumber/episode/$episodeNumber',
      queryParameters: params,
    );
    return TvEpisodeSummary.fromJson(jsonResponse);
  }

  /// Get the user rating status for a specific TV episode.
  Future<MediaAccountStates> getAccountStates(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
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
      'tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/account_states',
      queryParameters: params,
    );
    return MediaAccountStates.fromJson(jsonResponse);
  }

  /// Get the changes for a TV episode.
  Future<Map<String, dynamic>> getChanges(
    int episodeId, {
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
    return (await get('tv/episode/$episodeId/changes', queryParameters: params) as Map<String, dynamic>);
  }

  /// Get the credits for a TV episode.
  Future<TmdbCredits> getCredits(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/credits',
      queryParameters: params,
    );
    return TmdbCredits.fromJson(jsonResponse);
  }

  /// Get the external ids for a TV episode.
  Future<TmdbExternalIds> getExternalIds(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/external_ids',
      queryParameters: queryParameters,
    );
    return TmdbExternalIds.fromJson(jsonResponse);
  }

  /// Get the images that belong to a TV episode.
  Future<TmdbImagesResponse> getImages(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
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
      'tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/images',
      queryParameters: params,
    );
    return TmdbImagesResponse.fromJson(jsonResponse);
  }

  /// Get the translations for a TV episode.
  Future<TmdbListResponse<Map<String, dynamic>>> getTranslations(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/translations',
      queryParameters: queryParameters,
    );
    return TmdbListResponse.fromJson(
      jsonResponse,
      (i) => i,
      resultsKey: 'translations',
    );
  }

  /// Get the videos for a TV episode.
  Future<TmdbListResponse<TmdbVideo>> getVideos(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
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
      'tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/videos',
      queryParameters: params,
    );
    return TmdbListResponse.fromJson(jsonResponse, TmdbVideo.fromJson);
  }

  /// Rate a TV episode.
  Future<bool> addRating(
    int seriesId,
    int seasonNumber,
    int episodeNumber,
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
      'tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/rating',
      body: {'value': rating},
      queryParameters: params,
    );
    return jsonResponse['success'] == true;
  }

  /// Delete a rating.
  Future<bool> deleteRating(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
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
      'tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/rating',
      queryParameters: params,
    );
    return jsonResponse['success'] == true;
  }
}
