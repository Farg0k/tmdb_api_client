import 'base_tmdb_service.dart'; // Import the base service class.
import '../../tmdb_api_client.dart'; // <--- NEW: Import TmdbApiClient for constructor type.
// Need TmdbApiException for custom error.

/// [AccountService] handles all API interactions related to a user's TMDB account.
/// This includes fetching account details.
/// This service requires an authenticated session (`session_id`).
class AccountService extends BaseTmdbService {
  /// Constructor for [AccountService].
  /// It takes the main [TmdbApiClient] instance as a dependency, which it passes
  /// to its [BaseTmdbService] superclass.
  AccountService(super.client); // <--- Constructor now takes TmdbApiClient.

  /// Fetches the details of the currently authenticated user's account.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /account`.
  /// This method **requires a valid `session_id`** to be present in the
  /// shared [TmdbApiClientConfig] (managed by the [TmdbApiConnection]).
  /// If no `session_id` is available, this call will explicitly throw a [TmdbApiException]
  /// or fail from the API with an unauthorized error.
  ///
  /// Returns an [AccountDetails] object containing information about the user.
  /// Throws [TmdbApiException] if the API returns an error (e.g., unauthorized access),
  /// or [TmdbNetworkException] on network-related failures.
  Future<AccountDetails> getDetails() async {
    // Check if a session ID is available before making the request.
    // This explicit check provides clearer error handling for the developer
    // using this service, rather than just relying on an API 401 response.
    if (config.sessionId == null) {
      throw TmdbApiException(
        'Authentication required. Please create a user session first to fetch account details.',
        statusCode: 401, // Simulate an Unauthorized status.
        errorCode: 3, // TMDB's authentication failed error code.
      );
    }

    final jsonResponse = await get('account');
    return AccountDetails.fromJson(jsonResponse);
  }

  /// 2. Marks a movie or TV show as favorite.
  ///
  /// Corresponds to the TMDB API endpoint: `POST /account/{account_id}/favorite`.
  Future<bool> markAsFavorite({
    required int accountId,
    required MediaType mediaType,
    required int mediaId,
    required bool favorite,
  }) async {
    final jsonResponse = await post(
      'account/$accountId/favorite',
      body: {
        'media_type': mediaType.value,
        'media_id': mediaId,
        'favorite': favorite,
      },
    );
    return jsonResponse['success'] == true;
  }

  /// 3. Adds a movie or TV show to the user's watchlist.
  ///
  /// Corresponds to the TMDB API endpoint: `POST /account/{account_id}/watchlist`.
  Future<bool> addToWatchlist({
    required int accountId,
    required MediaType mediaType,
    required int mediaId,
    required bool watchlist,
  }) async {
    final jsonResponse = await post(
      'account/$accountId/watchlist',
      body: {
        'media_type': mediaType.value,
        'media_id': mediaId,
        'watchlist': watchlist,
      },
    );
    return jsonResponse['success'] == true;
  }

  /// 4. Get the list of favorite movies.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /account/{account_id}/favorite/movies`.
  Future<TmdbResponsePage<MovieSummary>> getFavoriteMovies({
    required int accountId,
    int page = 1,
    String? sortBy,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'sort_by': ?sortBy,
    };
    final jsonResponse = await get('account/$accountId/favorite/movies', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// 5. Get the list of favorite TV shows.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /account/{account_id}/favorite/tv`.
  Future<TmdbResponsePage<TvSummary>> getFavoriteTvShows({
    required int accountId,
    int page = 1,
    String? sortBy,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'sort_by': ?sortBy,
    };
    final jsonResponse = await get('account/$accountId/favorite/tv', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// 6. Get the list of movies on the user's watchlist.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /account/{account_id}/watchlist/movies`.
  Future<TmdbResponsePage<MovieSummary>> getWatchlistMovies({
    required int accountId,
    int page = 1,
    String? sortBy,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'sort_by': ?sortBy,
    };
    final jsonResponse = await get('account/$accountId/watchlist/movies', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// 7. Get the list of TV shows on the user's watchlist.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /account/{account_id}/watchlist/tv`.
  Future<TmdbResponsePage<TvSummary>> getWatchlistTvShows({
    required int accountId,
    int page = 1,
    String? sortBy,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'sort_by': ?sortBy,
    };
    final jsonResponse = await get('account/$accountId/watchlist/tv', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// 8. Get the list of rated movies.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /account/{account_id}/rated/movies`.
  Future<TmdbResponsePage<MovieSummary>> getRatedMovies({
    required int accountId,
    int page = 1,
    String? sortBy,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'sort_by': ?sortBy,
    };
    final jsonResponse = await get('account/$accountId/rated/movies', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// 9. Get the list of rated TV shows.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /account/{account_id}/rated/tv`.
  Future<TmdbResponsePage<TvSummary>> getRatedTvShows({
    required int accountId,
    int page = 1,
    String? sortBy,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'sort_by': ?sortBy,
    };
    final jsonResponse = await get('account/$accountId/rated/tv', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// 10. Get the list of rated TV episodes.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /account/{account_id}/rated/tv/episodes`.
  /// Note: This returns a generic Map for now as specific Episode models are not yet implemented.
  Future<Map<String, dynamic>> getRatedTvEpisodes({
    required int accountId,
    int page = 1,
    String? sortBy,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'sort_by': ?sortBy,
    };
    return get('account/$accountId/rated/tv/episodes', queryParameters: queryParams);
  }

  /// 11. Get the list of custom lists created by the user.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /account/{account_id}/lists`.
  Future<Map<String, dynamic>> getLists({
    required int accountId,
    int page = 1,
  }) async {
    final queryParams = {
      'page': page.toString(),
    };
    return get('account/$accountId/lists', queryParameters: queryParams);
  }
}