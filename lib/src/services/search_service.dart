import 'base_tmdb_service.dart';
import '../models/media_models.dart';
import '../models/people/person_summary.dart';
import '../models/collections/collection_summary.dart';
import '../models/common/tmdb_company.dart';
import '../models/keyword_models.dart';

/// [SearchService] handles API interactions related to searching TMDB.
class SearchService extends BaseTmdbService {
  SearchService(super.client);

  /// Search for collections.
  Future<TmdbResponsePage<CollectionSummary>> collection({
    required String query,
    bool? includeAdult,
    String? language,
    int? page,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'query': query,
      if (includeAdult != null) 'include_adult': includeAdult.toString(),
      'language': ?language,
      if (page != null) 'page': page.toString(),
      ...?queryParameters,
    };
    final jsonResponse = await get('search/collection', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, CollectionSummary.fromJson);
  }

  /// Search for companies.
  Future<TmdbResponsePage<TmdbCompany>> company({
    required String query,
    int? page,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'query': query,
      if (page != null) 'page': page.toString(),
      ...?queryParameters,
    };
    final jsonResponse = await get('search/company', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TmdbCompany.fromJson);
  }

  /// Search for keywords.
  Future<TmdbResponsePage<Keyword>> keyword({
    required String query,
    int? page,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'query': query,
      if (page != null) 'page': page.toString(),
      ...?queryParameters,
    };
    final jsonResponse = await get('search/keyword', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, Keyword.fromJson);
  }

  /// Search for movies.
  Future<TmdbResponsePage<MovieSummary>> movie({
    required String query,
    bool? includeAdult,
    String? language,
    int? page,
    String? region,
    int? year,
    int? primaryReleaseYear,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'query': query,
      if (includeAdult != null) 'include_adult': includeAdult.toString(),
      'language': ?language,
      if (page != null) 'page': page.toString(),
      'region': ?region,
      if (year != null) 'year': year.toString(),
      if (primaryReleaseYear != null) 'primary_release_year': primaryReleaseYear.toString(),
      ...?queryParameters,
    };
    final jsonResponse = await get('search/movie', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Multi-search (movies, TV shows, and people in one request).
  Future<TmdbResponsePage<Map<String, dynamic>>> multi({
    required String query,
    bool? includeAdult,
    String? language,
    int? page,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'query': query,
      if (includeAdult != null) 'include_adult': includeAdult.toString(),
      'language': ?language,
      if (page != null) 'page': page.toString(),
      ...?queryParameters,
    };
    final jsonResponse = await get('search/multi', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, (i) => i);
  }

  /// Search for people.
  Future<TmdbResponsePage<PersonSummary>> person({
    required String query,
    bool? includeAdult,
    String? language,
    int? page,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'query': query,
      if (includeAdult != null) 'include_adult': includeAdult.toString(),
      'language': ?language,
      if (page != null) 'page': page.toString(),
      ...?queryParameters,
    };
    final jsonResponse = await get('search/person', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, PersonSummary.fromJson);
  }

  /// Search for TV shows.
  Future<TmdbResponsePage<TvSummary>> tv({
    required String query,
    int? firstAirDateYear,
    bool? includeAdult,
    String? language,
    int? page,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'query': query,
      if (firstAirDateYear != null) 'first_air_date_year': firstAirDateYear.toString(),
      if (includeAdult != null) 'include_adult': includeAdult.toString(),
      'language': ?language,
      if (page != null) 'page': page.toString(),
      ...?queryParameters,
    };
    final jsonResponse = await get('search/tv', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }
}
