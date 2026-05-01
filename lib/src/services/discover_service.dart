import 'base_tmdb_service.dart';
import '../models/media_models.dart';

/// [DiscoverService] handles API interactions for the TMDB Discover endpoints.
///
/// Discover allows you to search for movies and TV shows using a wide range
/// of filters such as release date, rating, genres, and more.
class DiscoverService extends BaseTmdbService {
  DiscoverService(super.client);

  /// Find movies using various filters and sort options.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /discover/movie`.
  Future<TmdbResponsePage<MovieSummary>> movie({
    String? certification,
    String? certificationGte,
    String? certificationLte,
    String? certificationCountry,
    bool? includeAdult,
    bool? includeVideo,
    String? language,
    int? page,
    int? primaryReleaseYear,
    String? primaryReleaseDateGte,
    String? primaryReleaseDateLte,
    String? region,
    String? releaseDateGte,
    String? releaseDateLte,
    String? sortBy,
    double? voteAverageGte,
    double? voteAverageLte,
    double? voteCountGte,
    double? voteCountLte,
    String? watchRegion,
    String? withCast,
    String? withCompanies,
    String? withCrew,
    String? withGenres,
    String? withKeywords,
    String? withOriginCountry,
    String? withOriginalLanguage,
    String? withPeople,
    int? withReleaseType,
    int? withRuntimeGte,
    int? withRuntimeLte,
    String? withWatchMonetizationTypes,
    String? withWatchProviders,
    String? withoutCompanies,
    String? withoutGenres,
    String? withoutKeywords,
    String? withoutWatchProviders,
    int? year,
    Map<String, String>? queryParameters,
  }) async {
    final Map<String, String> params = {
      'certification': ?certification,
      'certification.gte': ?certificationGte,
      'certification.lte': ?certificationLte,
      'certification_country': ?certificationCountry,
      if (includeAdult != null) 'include_adult': includeAdult.toString(),
      if (includeVideo != null) 'include_video': includeVideo.toString(),
      'language': ?language,
      if (page != null) 'page': page.toString(),
      if (primaryReleaseYear != null)
        'primary_release_year': primaryReleaseYear.toString(),
      'primary_release_date.gte': ?primaryReleaseDateGte,
      'primary_release_date.lte': ?primaryReleaseDateLte,
      'region': ?region,
      'release_date.gte': ?releaseDateGte,
      'release_date.lte': ?releaseDateLte,
      'sort_by': ?sortBy,
      if (voteAverageGte != null) 'vote_average.gte': voteAverageGte.toString(),
      if (voteAverageLte != null) 'vote_average.lte': voteAverageLte.toString(),
      if (voteCountGte != null) 'vote_count.gte': voteCountGte.toString(),
      if (voteCountLte != null) 'vote_count.lte': voteCountLte.toString(),
      'watch_region': ?watchRegion,
      'with_cast': ?withCast,
      'with_companies': ?withCompanies,
      'with_crew': ?withCrew,
      'with_genres': ?withGenres,
      'with_keywords': ?withKeywords,
      'with_origin_country': ?withOriginCountry,
      'with_original_language': ?withOriginalLanguage,
      'with_people': ?withPeople,
      if (withReleaseType != null)
        'with_release_type': withReleaseType.toString(),
      if (withRuntimeGte != null) 'with_runtime.gte': withRuntimeGte.toString(),
      if (withRuntimeLte != null) 'with_runtime.lte': withRuntimeLte.toString(),
      'with_watch_monetization_types': ?withWatchMonetizationTypes,
      'with_watch_providers': ?withWatchProviders,
      'without_companies': ?withoutCompanies,
      'without_genres': ?withoutGenres,
      'without_keywords': ?withoutKeywords,
      'without_watch_providers': ?withoutWatchProviders,
      if (year != null) 'year': year.toString(),
      ...?queryParameters,
    };
    final jsonResponse = await get('discover/movie', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Find TV shows using various filters and sort options.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /discover/tv`.
  Future<TmdbResponsePage<TvSummary>> tv({
    String? certification,
    String? certificationCountry,
    bool? includeAdult,
    bool? includeNullFirstAirDates,
    String? language,
    int? page,
    int? firstAirDateYear,
    String? firstAirDateGte,
    String? firstAirDateLte,
    String? airDateGte,
    String? airDateLte,
    String? sortBy,
    double? voteAverageGte,
    double? voteAverageLte,
    double? voteCountGte,
    double? voteCountLte,
    String? watchRegion,
    String? withCompanies,
    String? withGenres,
    String? withKeywords,
    String? withNetworks,
    String? withOriginCountry,
    String? withOriginalLanguage,
    int? withRuntimeGte,
    int? withRuntimeLte,
    String? withStatus,
    int? withType,
    String? withWatchMonetizationTypes,
    String? withWatchProviders,
    String? withoutCompanies,
    String? withoutGenres,
    String? withoutKeywords,
    String? withoutWatchProviders,
    Map<String, String>? queryParameters,
  }) async {
    final Map<String, String> params = {
      'certification': ?certification,
      'certification_country': ?certificationCountry,
      if (includeAdult != null) 'include_adult': includeAdult.toString(),
      if (includeNullFirstAirDates != null)
        'include_null_first_air_dates': includeNullFirstAirDates.toString(),
      'language': ?language,
      if (page != null) 'page': page.toString(),
      if (firstAirDateYear != null)
        'first_air_date_year': firstAirDateYear.toString(),
      'first_air_date.gte': ?firstAirDateGte,
      'first_air_date.lte': ?firstAirDateLte,
      'air_date.gte': ?airDateGte,
      'air_date.lte': ?airDateLte,
      'sort_by': ?sortBy,
      if (voteAverageGte != null) 'vote_average.gte': voteAverageGte.toString(),
      if (voteAverageLte != null) 'vote_average.lte': voteAverageLte.toString(),
      if (voteCountGte != null) 'vote_count.gte': voteCountGte.toString(),
      if (voteCountLte != null) 'vote_count.lte': voteCountLte.toString(),
      'watch_region': ?watchRegion,
      'with_companies': ?withCompanies,
      'with_genres': ?withGenres,
      'with_keywords': ?withKeywords,
      'with_networks': ?withNetworks,
      'with_origin_country': ?withOriginCountry,
      'with_original_language': ?withOriginalLanguage,
      if (withRuntimeGte != null) 'with_runtime.gte': withRuntimeGte.toString(),
      if (withRuntimeLte != null) 'with_runtime.lte': withRuntimeLte.toString(),
      'with_status': ?withStatus,
      if (withType != null) 'with_type': withType.toString(),
      'with_watch_monetization_types': ?withWatchMonetizationTypes,
      'with_watch_providers': ?withWatchProviders,
      'without_companies': ?withoutCompanies,
      'without_genres': ?withoutGenres,
      'without_keywords': ?withoutKeywords,
      'without_watch_providers': ?withoutWatchProviders,
      ...?queryParameters,
    };
    final jsonResponse = await get('discover/tv', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }
}
