import 'base_tmdb_service.dart';
import '../models/change_models.dart';

/// [ChangesService] handles API interactions related to getting the list of changes
/// for movies, people, and TV shows.
class ChangesService extends BaseTmdbService {
  ChangesService(super.client);

  /// Get a list of all of the movie ids that have been changed in the past 24 hours.
  ///
  /// You can query it for up to 14 days worth of data using the [startDate] and [endDate] parameters.
  /// Corresponds to the TMDB API endpoint: `GET /movie/changes`.
  Future<ChangesResponse> getMovieChanges({
    int page = 1,
    String? startDate,
    String? endDate,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'start_date': ?startDate,
      'end_date': ?endDate,
    };
    final jsonResponse = await get(
      'movie/changes',
      queryParameters: queryParams,
    );
    return ChangesResponse.fromJson(jsonResponse);
  }

  /// Get a list of all of the TV show ids that have been changed in the past 24 hours.
  ///
  /// You can query it for up to 14 days worth of data using the [startDate] and [endDate] parameters.
  /// Corresponds to the TMDB API endpoint: `GET /tv/changes`.
  Future<ChangesResponse> getTvChanges({
    int page = 1,
    String? startDate,
    String? endDate,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'start_date': ?startDate,
      'end_date': ?endDate,
    };
    final jsonResponse = await get('tv/changes', queryParameters: queryParams);
    return ChangesResponse.fromJson(jsonResponse);
  }

  /// Get a list of all of the person ids that have been changed in the past 24 hours.
  ///
  /// You can query it for up to 14 days worth of data using the [startDate] and [endDate] parameters.
  /// Corresponds to the TMDB API endpoint: `GET /person/changes`.
  Future<ChangesResponse> getPeopleChanges({
    int page = 1,
    String? startDate,
    String? endDate,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'start_date': ?startDate,
      'end_date': ?endDate,
    };
    final jsonResponse = await get(
      'person/changes',
      queryParameters: queryParams,
    );
    return ChangesResponse.fromJson(jsonResponse);
  }
}
