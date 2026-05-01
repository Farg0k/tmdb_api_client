import 'base_tmdb_service.dart';
import '../models/media_models.dart';
import '../models/people/person_summary.dart';
import '../models/people/person_details.dart';
import '../models/common/tmdb_image.dart';
import '../models/people/person_tagged_images.dart';
import '../models/common/tmdb_external_ids.dart';
import '../models/common/tmdb_credit.dart';
import '../models/common/tmdb_list_response.dart';

/// [PeopleService] handles API interactions related to people on TMDB.
class PeopleService extends BaseTmdbService {
  PeopleService(super.client);

  /// --- People Lists ---

  /// Get a list of people ordered by popularity.
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
    return (await get('person/$personId/changes', queryParameters: params) as Map<String, dynamic>);
  }

  /// Get the combined movie and TV credits for a person.
  Future<TmdbCredits> getCombinedCredits(
    int personId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = personId != 0
        ? await get(
            'person/$personId/combined_credits',
            queryParameters: params,
          )
        : <String, dynamic>{};
    return TmdbCredits.fromJson(jsonResponse);
  }

  /// Get the external ids for a person.
  Future<TmdbExternalIds> getExternalIds(
    int personId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'person/$personId/external_ids',
      queryParameters: queryParameters,
    );
    return TmdbExternalIds.fromJson(jsonResponse);
  }

  /// Get the images for a person.
  Future<TmdbImagesResponse> getImages(
    int personId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'person/$personId/images',
      queryParameters: queryParameters,
    );
    return TmdbImagesResponse.fromJson(jsonResponse);
  }

  /// Get the most newly created person ID.
  Future<PersonDetails> getLatest({
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get('person/latest', queryParameters: params);
    return PersonDetails.fromJson(jsonResponse);
  }

  /// Get the movie credits for a person.
  Future<TmdbCredits> getMovieCredits(
    int personId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'person/$personId/movie_credits',
      queryParameters: params,
    );
    return TmdbCredits.fromJson(jsonResponse);
  }

  /// Get the TV credits for a person.
  Future<TmdbCredits> getTvCredits(
    int personId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'person/$personId/tv_credits',
      queryParameters: params,
    );
    return TmdbCredits.fromJson(jsonResponse);
  }

  /// Get the images that have been tagged with a specific person.
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
    final jsonResponse = await get(
      'person/$personId/tagged_images',
      queryParameters: params,
    );
    return PersonTaggedImagesResponse.fromJson(jsonResponse);
  }

  /// Get the translations for a person.
  Future<TmdbListResponse<Map<String, dynamic>>> getTranslations(
    int personId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'person/$personId/translations',
      queryParameters: queryParameters,
    );
    return TmdbListResponse.fromJson(
      jsonResponse,
      (i) => i,
      resultsKey: 'translations',
    );
  }
}
