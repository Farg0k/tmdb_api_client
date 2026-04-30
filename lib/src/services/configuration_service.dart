import 'base_tmdb_service.dart';
import '../models/configuration_models.dart';

/// [ConfigurationService] handles API interactions related to TMDB system configuration.
class ConfigurationService extends BaseTmdbService {
  ConfigurationService(super.client);

  /// Get the system wide configuration information (e.g., image base URLs).
  ///
  /// Corresponds to the TMDB API endpoint: `GET /configuration`.
  Future<TmdbApiConfigDetails> getDetails() async {
    final jsonResponse = await get('configuration');
    return TmdbApiConfigDetails.fromJson(jsonResponse);
  }

  /// Get the list of countries (ISO 3166-1 tags) used throughout TMDB.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /configuration/countries`.
  Future<List<TmdbCountry>> getCountries() async {
    final jsonResponse = await get('configuration/countries');
    return (jsonResponse as List)
        .map((e) => TmdbCountry.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get a list of the jobs and departments used on TMDB.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /configuration/jobs`.
  Future<List<TmdbJob>> getJobs() async {
    final jsonResponse = await get('configuration/jobs');
    return (jsonResponse as List)
        .map((e) => TmdbJob.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get the list of languages (ISO 639-1 tags) used throughout TMDB.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /configuration/languages`.
  Future<List<TmdbLanguage>> getLanguages() async {
    final jsonResponse = await get('configuration/languages');
    return (jsonResponse as List)
        .map((e) => TmdbLanguage.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get a list of the primary translations on TMDB.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /configuration/primary_translations`.
  Future<List<String>> getPrimaryTranslations() async {
    final jsonResponse = await get('configuration/primary_translations');
    return (jsonResponse as List).map((e) => e as String).toList();
  }

  /// Get the list of timezones used throughout TMDB.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /configuration/timezones`.
  Future<List<TmdbTimezone>> getTimezones() async {
    final jsonResponse = await get('configuration/timezones');
    return (jsonResponse as List)
        .map((e) => TmdbTimezone.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
