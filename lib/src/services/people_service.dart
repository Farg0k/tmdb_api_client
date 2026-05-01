import 'base_tmdb_service.dart';
import '../models/media_models.dart';
import '../models/people/person_summary.dart';
import '../models/people/person_details.dart';
import '../models/people/person_credits.dart';
import '../models/people/person_external_ids.dart';
import '../models/people/person_images.dart';
import '../models/people/person_tagged_images.dart';
import '../models/people/person_translations.dart';

/// [PeopleService] handles API interactions related to people on TMDB.
class PeopleService extends BaseTmdbService {
  PeopleService(super.client);

  /// --- People Lists ---

  /// Get a list of people ordered by popularity.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /person/popular`.
  Future<TmdbResponsePage<PersonSummary>> getPopular({
    int? page,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('person/popular', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, PersonSummary.fromJson);
  }

  /// --- Person Details & Info ---

  /// Get the primary information about a person.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /person/{person_id}`.
  Future<PersonDetails> getDetails(
    int personId, {
    String? language,
    String? appendToResponse,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'append_to_response': ?appendToResponse,
      ...?queryParameters,
    };
    final jsonResponse = await get('person/$personId', queryParameters: params);
    return PersonDetails.fromJson(jsonResponse);
  }

  /// Get the changes for a person.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /person/{person_id}/changes`.
  Future<Map<String, dynamic>> getChanges(
    int personId, {
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
    return get('person/$personId/changes', queryParameters: params);
  }

  /// Get the combined movie and TV credits for a person.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /person/{person_id}/combined_credits`.
  Future<PersonCredits> getCombinedCredits(
    int personId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('person/$personId/combined_credits', queryParameters: params);
    return PersonCredits.fromJson(jsonResponse);
  }

  /// Get the external ids for a person.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /person/{person_id}/external_ids`.
  Future<PersonExternalIds> getExternalIds(int personId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('person/$personId/external_ids', queryParameters: queryParameters);
    return PersonExternalIds.fromJson(jsonResponse);
  }

  /// Get the images for a person.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /person/{person_id}/images`.
  Future<PersonImagesResponse> getImages(int personId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('person/$personId/images', queryParameters: queryParameters);
    return PersonImagesResponse.fromJson(jsonResponse);
  }

  /// Get the most newly created person ID.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /person/latest`.
  Future<PersonDetails> getLatest({
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('person/latest', queryParameters: params);
    return PersonDetails.fromJson(jsonResponse);
  }

  /// Get the movie credits for a person.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /person/{person_id}/movie_credits`.
  Future<PersonCredits> getMovieCredits(
    int personId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('person/$personId/movie_credits', queryParameters: params);
    return PersonCredits.fromJson(jsonResponse);
  }

  /// Get the TV credits for a person.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /person/{person_id}/tv_credits`.
  Future<PersonCredits> getTvCredits(
    int personId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('person/$personId/tv_credits', queryParameters: params);
    return PersonCredits.fromJson(jsonResponse);
  }

  /// Get the images that have been tagged with a specific person.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /person/{person_id}/tagged_images`.
  Future<PersonTaggedImagesResponse> getTaggedImages(
    int personId, {
    int? page,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('person/$personId/tagged_images', queryParameters: params);
    return PersonTaggedImagesResponse.fromJson(jsonResponse);
  }

  /// Get the translations for a person.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /person/{person_id}/translations`.
  Future<PersonTranslationsResponse> getTranslations(int personId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('person/$personId/translations', queryParameters: queryParameters);
    return PersonTranslationsResponse.fromJson(jsonResponse);
  }
}
