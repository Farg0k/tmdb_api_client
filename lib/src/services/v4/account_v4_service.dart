import 'base_v4_service.dart';
import '../../models/media_models.dart';
import '../../models/v4/tmdb_v4_account_lists_response.dart';

/// [AccountV4Service] handles API interactions for TMDB v4 account-specific endpoints.
class AccountV4Service extends BaseV4Service {
  AccountV4Service(super.client, super.connection);

  /// Get all lists created by the user.
  Future<TmdbAccountV4ListsResponse> getLists(
    String accountId, {
    int? page,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'account/$accountId/lists',
      queryParameters: params,
    );
    return TmdbAccountV4ListsResponse.fromJson(jsonResponse);
  }

  /// Get the list of favorite movies for an account.
  Future<TmdbResponsePage<MovieSummary>> getMovieFavorites(
    String accountId, {
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
      'account/$accountId/movie/favorites',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the list of favorite TV shows for an account.
  Future<TmdbResponsePage<TvSummary>> getTvFavorites(
    String accountId, {
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
      'account/$accountId/tv/favorites',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get the list of recommended movies for an account.
  Future<TmdbResponsePage<MovieSummary>> getMovieRecommendations(
    String accountId, {
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
      'account/$accountId/movie/recommendations',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the list of recommended TV shows for an account.
  Future<TmdbResponsePage<TvSummary>> getTvRecommendations(
    String accountId, {
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
      'account/$accountId/tv/recommendations',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get the list of movies on an account's watchlist.
  Future<TmdbResponsePage<MovieSummary>> getMovieWatchlist(
    String accountId, {
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
      'account/$accountId/movie/watchlist',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the list of TV shows on an account's watchlist.
  Future<TmdbResponsePage<TvSummary>> getTvWatchlist(
    String accountId, {
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
      'account/$accountId/tv/watchlist',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }
}
