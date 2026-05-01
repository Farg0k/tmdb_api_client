import 'base_tmdb_service.dart';
import '../models/configuration_models.dart';

/// [ConfigurationService] handles API interactions related to TMDB system configuration.
class ConfigurationService extends BaseTmdbService {
  ConfigurationService(super.client);

  /// Get the system wide configuration information.
  Future<TmdbApiConfigDetails> getDetails({Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('configuration', queryParameters: queryParameters);
    return TmdbApiConfigDetails.fromJson(jsonResponse);
  }

  /// Get the list of countries used throughout TMDB.
  Future<List<TmdbCountry>> getCountries({Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('configuration/countries', queryParameters: queryParameters);
    return (jsonResponse as List)
        .map((e) => TmdbCountry.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get a list of the jobs and departments used on TMDB.
  Future<List<TmdbJob>> getJobs({Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('configuration/jobs', queryParameters: queryParameters);
    return (jsonResponse as List)
        .map((e) => TmdbJob.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get the list of languages used throughout TMDB.
  Future<List<TmdbLanguage>> getLanguages({Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('configuration/languages', queryParameters: queryParameters);
    return (jsonResponse as List)
        .map((e) => TmdbLanguage.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get a list of the primary translations on TMDB.
  Future<List<String>> getPrimaryTranslations({Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('configuration/primary_translations', queryParameters: queryParameters);
    return (jsonResponse as List).map((e) => e as String).toList();
  }

  /// Get the list of timezones used throughout TMDB.
  Future<List<TmdbTimezone>> getTimezones({Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('configuration/timezones', queryParameters: queryParameters);
    return (jsonResponse as List)
        .map((e) => TmdbTimezone.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
