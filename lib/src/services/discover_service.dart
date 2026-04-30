import 'base_tmdb_service.dart';
import '../models/media_models.dart';

/// [DiscoverService] handles API interactions for the TMDB Discover endpoints.
///
/// Discover allows you to search for movies and TV shows using a wide range
/// of filters such as release date, rating, genres, and more.
class DiscoverService extends BaseTmdbService {
  DiscoverService(super.client);

  /// Find movies using over 30 different filters and sort options.
  ///
  /// [queryParameters] can include filters like `with_genres`, `primary_release_year`,
  /// `vote_average.gte`, `sort_by`, etc.
  /// Corresponds to the TMDB API endpoint: `GET /discover/movie`.
  Future<TmdbResponsePage<MovieSummary>> movie({
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get('discover/movie', queryParameters: queryParameters);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Find TV shows using various filters and sort options.
  ///
  /// [queryParameters] can include filters like `with_genres`, `first_air_date_year`,
  /// `vote_average.gte`, `with_networks`, etc.
  /// Corresponds to the TMDB API endpoint: `GET /discover/tv`.
  Future<TmdbResponsePage<TvSummary>> tv({
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get('discover/tv', queryParameters: queryParameters);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }
}
