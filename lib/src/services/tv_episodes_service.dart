import 'base_tmdb_service.dart';
import '../models/tv/tv_episode_summary.dart';
import '../models/tv/episodes/tv_episode_account_states.dart';
import '../models/tv/tv_credits.dart';
import '../models/tv/tv_external_ids.dart';
import '../models/tv/tv_images.dart';
import '../models/tv/tv_videos.dart';
import '../models/tv/tv_translations.dart';

/// [TvEpisodesService] handles API interactions related to TV episodes on TMDB.
class TvEpisodesService extends BaseTmdbService {
  TvEpisodesService(super.client);

  /// Get the details of a TV episode.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/{series_id}/season/{season_number}/episode/{episode_number}`.
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
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/episode/$episodeNumber', queryParameters: params);
    return TvEpisodeSummary.fromJson(jsonResponse);
  }

  /// Get the user rating status for a specific TV episode.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/{series_id}/season/{season_number}/episode/{episode_number}/account_states`.
  Future<TvEpisodeAccountStates> getAccountStates(
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
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/account_states', queryParameters: params);
    return TvEpisodeAccountStates.fromJson(jsonResponse);
  }

  /// Get the changes for a TV episode.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/episode/{episode_id}/changes`.
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
    return get('tv/episode/$episodeId/changes', queryParameters: params);
  }

  /// Get the credits (cast, crew and guest stars) for a TV episode.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/{series_id}/season/{season_number}/episode/{episode_number}/credits`.
  Future<TvCredits> getCredits(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/credits', queryParameters: params);
    return TvCredits.fromJson(jsonResponse);
  }

  /// Get the external ids for a TV episode.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/{series_id}/season/{season_number}/episode/{episode_number}/external_ids`.
  Future<TvExternalIds> getExternalIds(int seriesId, int seasonNumber, int episodeNumber, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/external_ids', queryParameters: queryParameters);
    return TvExternalIds.fromJson(jsonResponse);
  }

  /// Get the images that belong to a TV episode.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/{series_id}/season/{season_number}/episode/{episode_number}/images`.
  Future<TvImagesResponse> getImages(
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
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/images', queryParameters: params);
    return TvImagesResponse.fromJson(jsonResponse);
  }

  /// Get the translations for a TV episode.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/{series_id}/season/{season_number}/episode/{episode_number}/translations`.
  Future<TvTranslationsResponse> getTranslations(int seriesId, int seasonNumber, int episodeNumber, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/translations', queryParameters: queryParameters);
    return TvTranslationsResponse.fromJson(jsonResponse);
  }

  /// Get the videos that have been added to a TV episode.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/{series_id}/season/{season_number}/episode/{episode_number}/videos`.
  Future<TvVideosResponse> getVideos(
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
    final jsonResponse = await get('tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/videos', queryParameters: params);
    return TvVideosResponse.fromJson(jsonResponse);
  }

  /// Rate a TV episode.
  ///
  /// Corresponds to the TMDB API endpoint: `POST /tv/{series_id}/season/{season_number}/episode/{episode_number}/rating`.
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

  /// Delete a rating for a TV episode.
  ///
  /// Corresponds to the TMDB API endpoint: `DELETE /tv/{series_id}/season/{season_number}/episode/{episode_number}/rating`.
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
    final jsonResponse = await delete('tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/rating', queryParameters: params);
    return jsonResponse['success'] == true;
  }
}
