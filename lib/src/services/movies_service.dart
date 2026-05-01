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
// For getLists

/// [MoviesService] handles API interactions related to movies on TMDB.
class MoviesService extends BaseTmdbService {
  MoviesService(super.client);

  /// --- Movie Lists ---

  /// Get a list of movies that are currently in theatres.
  Future<TmdbResponsePage<MovieSummary>> getNowPlaying({
    int page = 1,
    String? language,
    String? region,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'language': ?language,
      'region': ?region,
    };
    final jsonResponse = await get('movie/now_playing', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get a list of the current popular movies on TMDB.
  Future<TmdbResponsePage<MovieSummary>> getPopular({
    int page = 1,
    String? language,
    String? region,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'language': ?language,
      'region': ?region,
    };
    final jsonResponse = await get('movie/popular', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the top rated movies on TMDB.
  Future<TmdbResponsePage<MovieSummary>> getTopRated({
    int page = 1,
    String? language,
    String? region,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'language': ?language,
      'region': ?region,
    };
    final jsonResponse = await get('movie/top_rated', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get a list of upcoming movies in theatres.
  Future<TmdbResponsePage<MovieSummary>> getUpcoming({
    int page = 1,
    String? language,
    String? region,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'language': ?language,
      'region': ?region,
    };
    final jsonResponse = await get('movie/upcoming', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// --- Movie Details & Info ---

  /// Get the primary information about a movie.
  Future<MovieDetails> getDetails(int movieId, {String? language, String? appendToResponse}) async {
    final queryParams = {
      'language': ?language,
      'append_to_response': ?appendToResponse,
    };
    final jsonResponse = await get('movie/$movieId', queryParameters: queryParams);
    return MovieDetails.fromJson(jsonResponse);
  }

  /// Get the user rating and status for a specific movie.
  Future<MovieAccountStates> getAccountStates(int movieId) async {
    final jsonResponse = await get('movie/$movieId/account_states');
    return MovieAccountStates.fromJson(jsonResponse);
  }

  /// Get all of the alternative titles for a movie.
  Future<MovieAlternativeTitlesResponse> getAlternativeTitles(int movieId, {String? country}) async {
    final queryParams = {
      'country': ?country,
    };
    final jsonResponse = await get('movie/$movieId/alternative_titles', queryParameters: queryParams);
    return MovieAlternativeTitlesResponse.fromJson(jsonResponse);
  }

  /// Get the changes for a movie.
  Future<Map<String, dynamic>> getChanges(int movieId, {String? startDate, String? endDate, int page = 1}) async {
    final queryParams = {
      'page': page.toString(),
      'start_date': ?startDate,
      'end_date': ?endDate,
    };
    return get('movie/$movieId/changes', queryParameters: queryParams);
  }

  /// Get the cast and crew for a movie.
  Future<MovieCredits> getCredits(int movieId, {String? language}) async {
    final queryParams = {
      'language': ?language,
    };
    final jsonResponse = await get('movie/$movieId/credits', queryParameters: queryParams);
    return MovieCredits.fromJson(jsonResponse);
  }

  /// Get the external ids for a movie.
  Future<MovieExternalIds> getExternalIds(int movieId) async {
    final jsonResponse = await get('movie/$movieId/external_ids');
    return MovieExternalIds.fromJson(jsonResponse);
  }

  /// Get the images that belong to a movie.
  Future<MovieImagesResponse> getImages(int movieId, {String? language, String? includeImageLanguage}) async {
    final queryParams = {
      'language': ?language,
      'include_image_language': ?includeImageLanguage,
    };
    final jsonResponse = await get('movie/$movieId/images', queryParameters: queryParams);
    return MovieImagesResponse.fromJson(jsonResponse);
  }

  /// Get the keywords that have been added to a movie.
  Future<MovieKeywordsResponse> getKeywords(int movieId) async {
    final jsonResponse = await get('movie/$movieId/keywords');
    return MovieKeywordsResponse.fromJson(jsonResponse);
  }

  /// Get the most newly created movie ID.
  Future<MovieDetails> getLatest({String? language}) async {
    final queryParams = {
      'language': ?language,
    };
    final jsonResponse = await get('movie/latest', queryParameters: queryParams);
    return MovieDetails.fromJson(jsonResponse);
  }

  /// Get the lists that a movie has been added to.
  Future<TmdbResponsePage<Map<String, dynamic>>> getLists(int movieId, {int page = 1, String? language}) async {
    final queryParams = {
      'page': page.toString(),
      'language': ?language,
    };
    final jsonResponse = await get('movie/$movieId/lists', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, (i) => i);
  }

  /// Get a list of recommended movies for a movie.
  Future<TmdbResponsePage<MovieSummary>> getRecommendations(int movieId, {int page = 1, String? language}) async {
    final queryParams = {
      'page': page.toString(),
      'language': ?language,
    };
    final jsonResponse = await get('movie/$movieId/recommendations', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the release date and certification information by country for a movie.
  Future<MovieReleaseDatesResponse> getReleaseDates(int movieId) async {
    final jsonResponse = await get('movie/$movieId/release_dates');
    return MovieReleaseDatesResponse.fromJson(jsonResponse);
  }

  /// Get the user reviews for a movie.
  Future<MovieReviewsResponse> getReviews(int movieId, {int page = 1, String? language}) async {
    final queryParams = {
      'page': page.toString(),
      'language': ?language,
    };
    final jsonResponse = await get('movie/$movieId/reviews', queryParameters: queryParams);
    return MovieReviewsResponse.fromJson(jsonResponse);
  }

  /// Get a list of similar movies.
  Future<TmdbResponsePage<MovieSummary>> getSimilar(int movieId, {int page = 1, String? language}) async {
    final queryParams = {
      'page': page.toString(),
      'language': ?language,
    };
    final jsonResponse = await get('movie/$movieId/similar', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get a list of translations that have been created for a movie.
  Future<Map<String, dynamic>> getTranslations(int movieId) async {
    return get('movie/$movieId/translations');
  }

  /// Get the videos that have been added to a movie.
  Future<MovieVideosResponse> getVideos(int movieId, {String? language}) async {
    final queryParams = {
      'language': ?language,
    };
    final jsonResponse = await get('movie/$movieId/videos', queryParameters: queryParams);
    return MovieVideosResponse.fromJson(jsonResponse);
  }

  /// Get a list of watch providers for a movie.
  Future<MovieWatchProvidersResponse> getWatchProviders(int movieId) async {
    final jsonResponse = await get('movie/$movieId/watch/providers');
    return MovieWatchProvidersResponse.fromJson(jsonResponse);
  }

  /// --- Movie Actions ---

  /// Rate a movie.
  Future<bool> addRating(int movieId, double rating) async {
    final jsonResponse = await post(
      'movie/$movieId/rating',
      body: {'value': rating},
    );
    return jsonResponse['success'] == true;
  }

  /// Delete a rating for a movie.
  Future<bool> deleteRating(int movieId) async {
    final jsonResponse = await delete('movie/$movieId/rating');
    return jsonResponse['success'] == true;
  }
}
