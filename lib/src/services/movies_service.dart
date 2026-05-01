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
import '../models/movies/movie_details.dart';
import '../models/movies/movie_release_dates.dart';
import '../models/keyword_models.dart';

/// [MoviesService] handles API interactions related to movies on TMDB.
class MoviesService extends BaseTmdbService {
  MoviesService(super.client);

  /// --- Movie Lists ---

  /// Get a list of movies that are currently in theatres.
  Future<TmdbResponsePage<MovieSummary>> getNowPlaying({
    int? page,
    String? language,
    String? region,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      'region': ?region,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'movie/now_playing',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get a list of the current popular movies on TMDB.
  Future<TmdbResponsePage<MovieSummary>> getPopular({
    int? page,
    String? language,
    String? region,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      'region': ?region,
      ...?queryParameters,
    };
    final jsonResponse = await get('movie/popular', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the top rated movies on TMDB.
  Future<TmdbResponsePage<MovieSummary>> getTopRated({
    int? page,
    String? language,
    String? region,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      'region': ?region,
      ...?queryParameters,
    };
    final jsonResponse = await get('movie/top_rated', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get a list of upcoming movies in theatres.
  Future<TmdbResponsePage<MovieSummary>> getUpcoming({
    int? page,
    String? language,
    String? region,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      'region': ?region,
      ...?queryParameters,
    };
    final jsonResponse = await get('movie/upcoming', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// --- Movie Details & Info ---

  /// Get the primary information about a movie.
  Future<MovieDetails> getDetails(
    int movieId, {
    String? language,
    String? appendToResponse,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'append_to_response': ?appendToResponse,
      ...?queryParameters,
    };
    final jsonResponse = await get('movie/$movieId', queryParameters: params);
    return MovieDetails.fromJson(jsonResponse);
  }

  /// Get the user rating and status for a specific movie.
  Future<MediaAccountStates> getAccountStates(
    int movieId, {
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
      'movie/$movieId/account_states',
      queryParameters: params,
    );
    return MediaAccountStates.fromJson(jsonResponse);
  }

  /// Get all of the alternative titles for a movie.
  Future<TmdbListResponse<AlternativeTitle>> getAlternativeTitles(
    int movieId, {
    String? country,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'country': ?country, ...?queryParameters};
    final jsonResponse = await get(
      'movie/$movieId/alternative_titles',
      queryParameters: params,
    );
    return TmdbListResponse.fromJson(
      jsonResponse,
      AlternativeTitle.fromJson,
      resultsKey: 'titles',
    );
  }

  /// Get the changes for a movie.
  Future<Map<String, dynamic>> getChanges(
    int movieId, {
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
    return get('movie/$movieId/changes', queryParameters: params);
  }

  /// Get the cast and crew for a movie.
  Future<TmdbCredits> getCredits(
    int movieId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'movie/$movieId/credits',
      queryParameters: params,
    );
    return TmdbCredits.fromJson(jsonResponse);
  }

  /// Get the external ids for a movie.
  Future<TmdbExternalIds> getExternalIds(
    int movieId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'movie/$movieId/external_ids',
      queryParameters: queryParameters,
    );
    return TmdbExternalIds.fromJson(jsonResponse);
  }

  /// Get the images that belong to a movie.
  Future<TmdbImagesResponse> getImages(
    int movieId, {
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
      'movie/$movieId/images',
      queryParameters: params,
    );
    return TmdbImagesResponse.fromJson(jsonResponse);
  }

  /// Get the keywords that have been added to a movie.
  Future<TmdbListResponse<Keyword>> getKeywords(
    int movieId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'movie/$movieId/keywords',
      queryParameters: queryParameters,
    );
    return TmdbListResponse.fromJson(
      jsonResponse,
      Keyword.fromJson,
      resultsKey: 'keywords',
    );
  }

  /// Get the most newly created movie ID.
  Future<MovieDetails> getLatest({
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get('movie/latest', queryParameters: params);
    return MovieDetails.fromJson(jsonResponse);
  }

  /// Get the lists that a movie has been added to.
  Future<TmdbResponsePage<Map<String, dynamic>>> getLists(
    int movieId, {
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
      'movie/$movieId/lists',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, (i) => i);
  }

  /// Get a list of recommended movies for a movie.
  Future<TmdbResponsePage<MovieSummary>> getRecommendations(
    int movieId, {
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
      'movie/$movieId/recommendations',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the release date and certification information by country for a movie.
  Future<MovieReleaseDatesResponse> getReleaseDates(
    int movieId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'movie/$movieId/release_dates',
      queryParameters: queryParameters,
    );
    return MovieReleaseDatesResponse.fromJson(jsonResponse);
  }

  /// Get the user reviews for a movie.
  Future<TmdbResponsePage<TmdbReview>> getReviews(
    int movieId, {
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
      'movie/$movieId/reviews',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, TmdbReview.fromJson);
  }

  /// Get a list of similar movies.
  Future<TmdbResponsePage<MovieSummary>> getSimilar(
    int movieId, {
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
      'movie/$movieId/similar',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get a list of translations that have been created for a movie.
  Future<Map<String, dynamic>> getTranslations(
    int movieId, {
    Map<String, String>? queryParameters,
  }) async {
    return get('movie/$movieId/translations', queryParameters: queryParameters);
  }

  /// Get the videos that have been added to a movie.
  Future<TmdbListResponse<TmdbVideo>> getVideos(
    int movieId, {
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
      'movie/$movieId/videos',
      queryParameters: params,
    );
    return TmdbListResponse.fromJson(jsonResponse, TmdbVideo.fromJson);
  }

  /// Get a list of watch providers for a movie.
  Future<TmdbWatchProvidersResponse> getWatchProviders(
    int movieId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'movie/$movieId/watch/providers',
      queryParameters: queryParameters,
    );
    return TmdbWatchProvidersResponse.fromJson(jsonResponse);
  }

  /// --- Movie Actions ---

  /// Rate a movie.
  Future<bool> addRating(
    int movieId,
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
      'movie/$movieId/rating',
      body: {'value': rating},
      queryParameters: params,
    );
    return jsonResponse['success'] == true;
  }

  /// Delete a rating for a movie.
  Future<bool> deleteRating(
    int movieId, {
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
      'movie/$movieId/rating',
      queryParameters: params,
    );
    return jsonResponse['success'] == true;
  }
}
