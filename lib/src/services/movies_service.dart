import 'base_tmdb_service.dart';
import '../models/media_models.dart';
import '../models/movies/movie_details.dart';
import '../models/movies/movie_account_states.dart';
import '../models/movies/movie_credits.dart';
import '../models/movies/movie_videos.dart';
import '../models/movies/movie_reviews.dart';
import '../models/movies/movie_external_ids.dart';
import '../models/movies/movie_release_dates.dart';
import '../models/movies/movie_alternative_titles.dart';
import '../models/movies/movie_images.dart';
import '../models/movies/movie_keywords.dart';
import '../models/movies/movie_watch_providers.dart';

/// [MoviesService] handles API interactions related to movies on TMDB.
class MoviesService extends BaseTmdbService {
  MoviesService(super.client);

  /// --- Movie Lists ---

  /// Get a list of movies that are currently in theatres.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/now_playing`.
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
    final jsonResponse = await get('movie/now_playing', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get a list of the current popular movies on TMDB.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/popular`.
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
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/top_rated`.
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
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/upcoming`.
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
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}`.
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
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/account_states`.
  Future<MovieAccountStates> getAccountStates(
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
    final jsonResponse = await get('movie/$movieId/account_states', queryParameters: params);
    return MovieAccountStates.fromJson(jsonResponse);
  }

  /// Get all of the alternative titles for a movie.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/alternative_titles`.
  Future<MovieAlternativeTitlesResponse> getAlternativeTitles(
    int movieId, {
    String? country,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'country': ?country,
      ...?queryParameters,
    };
    final jsonResponse = await get('movie/$movieId/alternative_titles', queryParameters: params);
    return MovieAlternativeTitlesResponse.fromJson(jsonResponse);
  }

  /// Get the changes for a movie.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/changes`.
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
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/credits`.
  Future<MovieCredits> getCredits(
    int movieId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('movie/$movieId/credits', queryParameters: params);
    return MovieCredits.fromJson(jsonResponse);
  }

  /// Get the external ids for a movie.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/external_ids`.
  Future<MovieExternalIds> getExternalIds(int movieId, {Map<String, String>? queryParameters}) async {
    return MovieExternalIds.fromJson(await get('movie/$movieId/external_ids', queryParameters: queryParameters));
  }

  /// Get the images that belong to a movie.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/images`.
  Future<MovieImagesResponse> getImages(
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
    final jsonResponse = await get('movie/$movieId/images', queryParameters: params);
    return MovieImagesResponse.fromJson(jsonResponse);
  }

  /// Get the keywords that have been added to a movie.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/keywords`.
  Future<MovieKeywordsResponse> getKeywords(int movieId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('movie/$movieId/keywords', queryParameters: queryParameters);
    return MovieKeywordsResponse.fromJson(jsonResponse);
  }

  /// Get the most newly created movie ID.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/latest`.
  Future<MovieDetails> getLatest({
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('movie/latest', queryParameters: params);
    return MovieDetails.fromJson(jsonResponse);
  }

  /// Get the lists that a movie has been added to.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/lists`.
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
    final jsonResponse = await get('movie/$movieId/lists', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, (i) => i);
  }

  /// Get a list of recommended movies for a movie.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/recommendations`.
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
    final jsonResponse = await get('movie/$movieId/recommendations', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the release date and certification information by country for a movie.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/release_dates`.
  Future<MovieReleaseDatesResponse> getReleaseDates(int movieId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('movie/$movieId/release_dates', queryParameters: queryParameters);
    return MovieReleaseDatesResponse.fromJson(jsonResponse);
  }

  /// Get the user reviews for a movie.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/reviews`.
  Future<MovieReviewsResponse> getReviews(
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
    final jsonResponse = await get('movie/$movieId/reviews', queryParameters: params);
    return MovieReviewsResponse.fromJson(jsonResponse);
  }

  /// Get a list of similar movies.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/similar`.
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
    final jsonResponse = await get('movie/$movieId/similar', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get a list of translations that have been created for a movie.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/translations`.
  Future<Map<String, dynamic>> getTranslations(int movieId, {Map<String, String>? queryParameters}) async {
    return get('movie/$movieId/translations', queryParameters: queryParameters);
  }

  /// Get the videos that have been added to a movie.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/videos`.
  Future<MovieVideosResponse> getVideos(
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
    final jsonResponse = await get('movie/$movieId/videos', queryParameters: params);
    return MovieVideosResponse.fromJson(jsonResponse);
  }

  /// Get a list of watch providers for a movie.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/{movie_id}/watch/providers`.
  Future<MovieWatchProvidersResponse> getWatchProviders(int movieId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('movie/$movieId/watch/providers', queryParameters: queryParameters);
    return MovieWatchProvidersResponse.fromJson(jsonResponse);
  }

  /// --- Movie Actions ---

  /// Rate a movie.
  ///
  /// Corresponds to the TMDB API endpoint: `POST /movie/{movie_id}/rating`.
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
  ///
  /// Corresponds to the TMDB API endpoint: `DELETE /movie/{movie_id}/rating`.
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
    final jsonResponse = await delete('movie/$movieId/rating', queryParameters: params);
    return jsonResponse['success'] == true;
  }
}
