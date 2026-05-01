import 'base_tmdb_service.dart';
import '../../tmdb_api_client.dart';

/// [AccountService] handles all API interactions related to a user's TMDB account.
class AccountService extends BaseTmdbService {
  AccountService(super.client);

  /// 1. Fetches the details of the currently authenticated user's account.
  Future<AccountDetails> getDetails({Map<String, String>? queryParameters}) async {
    if (config.sessionId == null) {
      throw TmdbApiException(
        'Authentication required. Please create a user session first to fetch account details.',
        statusCode: 401,
        errorCode: 3,
      );
    }

    final jsonResponse = await get('account', queryParameters: queryParameters);
    return AccountDetails.fromJson(jsonResponse);
  }

  /// 2. Marks a movie or TV show as favorite.
  Future<bool> markAsFavorite({
    required int accountId,
    required MediaType mediaType,
    required int mediaId,
    required bool favorite,
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await post(
      'account/$accountId/favorite',
      body: {
        'media_type': mediaType.value,
        'media_id': mediaId,
        'favorite': favorite,
      },
      queryParameters: queryParameters,
    );
    return jsonResponse['success'] == true;
  }

  /// 3. Adds a movie or TV show to the user's watchlist.
  Future<bool> addToWatchlist({
    required int accountId,
    required MediaType mediaType,
    required int mediaId,
    required bool watchlist,
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await post(
      'account/$accountId/watchlist',
      body: {
        'media_type': mediaType.value,
        'media_id': mediaId,
        'watchlist': watchlist,
      },
      queryParameters: queryParameters,
    );
    return jsonResponse['success'] == true;
  }

  /// 4. Get the list of favorite movies.
  Future<TmdbResponsePage<MovieSummary>> getFavoriteMovies({
    required int accountId,
    int? page,
    String? sortBy,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('account/$accountId/favorite/movies', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// 5. Get the list of favorite TV shows.
  Future<TmdbResponsePage<TvSummary>> getFavoriteTvShows({
    required int accountId,
    int? page,
    String? sortBy,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('account/$accountId/favorite/tv', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// 6. Get the list of movies on the user's watchlist.
  Future<TmdbResponsePage<MovieSummary>> getWatchlistMovies({
    required int accountId,
    int? page,
    String? sortBy,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('account/$accountId/watchlist/movies', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// 7. Get the list of TV shows on the user's watchlist.
  Future<TmdbResponsePage<TvSummary>> getWatchlistTvShows({
    required int accountId,
    int? page,
    String? sortBy,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('account/$accountId/watchlist/tv', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// 8. Get the list of rated movies.
  Future<TmdbResponsePage<MovieSummary>> getRatedMovies({
    required int accountId,
    int? page,
    String? sortBy,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('account/$accountId/rated/movies', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// 9. Get the list of rated TV shows.
  Future<TmdbResponsePage<TvSummary>> getRatedTvShows({
    required int accountId,
    int? page,
    String? sortBy,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('account/$accountId/rated/tv', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// 10. Get the list of rated TV episodes.
  Future<TmdbResponsePage<RatedEpisodeSummary>> getRatedTvEpisodes({
    required int accountId,
    int? page,
    String? sortBy,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('account/$accountId/rated/tv/episodes', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, RatedEpisodeSummary.fromJson);
  }

  /// 11. Get the list of custom lists created by the user.
  Future<Map<String, dynamic>> getLists({
    required int accountId,
    int? page,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    return get('account/$accountId/lists', queryParameters: params);
  }
}
