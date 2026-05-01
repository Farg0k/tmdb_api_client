import 'package:http/http.dart' as http; // Alias 'http' for the HTTP client library.

// Core components - the actual HTTP communication layer.
import 'src/core/tmdb_api_connection.dart'; // <--- NEW: Import the API connection class.

// Models - data structures for configuration, authentication, and account details.
import 'src/models/tmdb_api_client_config.dart';

// Services - high-level interfaces for specific API functionalities.
import 'src/services/authentication_service.dart';
import 'src/services/account_service.dart';
import 'src/services/certifications_service.dart';
import 'src/services/changes_service.dart';
import 'src/services/collections_service.dart';
import 'src/services/companies_service.dart';
import 'src/services/configuration_service.dart';
import 'src/services/credits_service.dart';
import 'src/services/discover_service.dart';
import 'src/services/find_service.dart';
import 'src/services/genres_service.dart';
import 'src/services/guest_sessions_service.dart';
import 'src/services/keywords_service.dart';
import 'src/services/lists_service.dart';
import 'src/services/movies_service.dart';
import 'src/services/networks_service.dart';
import 'src/services/people_service.dart';
import 'src/services/reviews_service.dart';
import 'src/services/trending_service.dart';
import 'src/services/search_service.dart';
import 'src/services/tv_service.dart';

// Exports for the public API of the package.
// This makes these classes/exceptions directly accessible when importing 'package:tmdb_api_client/tmdb_api_client.dart'.
export 'src/models/tmdb_api_client_config.dart';
export 'src/models/authentication_models.dart';
export 'src/models/account_models.dart';
export 'src/models/media_models.dart';
export 'src/models/certification_models.dart';
export 'src/models/change_models.dart';
export 'src/models/collection_models.dart';
export 'src/models/collections/collection_summary.dart';
export 'src/models/company_models.dart';
export 'src/models/companies/company_summary.dart';
export 'src/models/configuration_models.dart';
export 'src/models/credit_models.dart';
export 'src/models/find_models.dart';
export 'src/models/genre_models.dart';
export 'src/models/keyword_models.dart';
export 'src/models/list_models.dart';
export 'src/models/movies/movie_details.dart';
export 'src/models/movies/movie_account_states.dart';
export 'src/models/movies/movie_credits.dart';
export 'src/models/movies/movie_videos.dart';
export 'src/models/movies/movie_reviews.dart';
export 'src/models/movies/movie_external_ids.dart';
export 'src/models/movies/movie_release_dates.dart';
export 'src/models/movies/movie_alternative_titles.dart';
export 'src/models/movies/movie_images.dart';
export 'src/models/movies/movie_keywords.dart';
export 'src/models/movies/movie_watch_providers.dart';
export 'src/models/networks/network_details.dart';
export 'src/models/networks/network_alternative_names.dart';
export 'src/models/networks/network_logos.dart';
export 'src/models/people/person_summary.dart';
export 'src/models/people/person_details.dart';
export 'src/models/people/person_credits.dart';
export 'src/models/people/person_external_ids.dart';
export 'src/models/people/person_images.dart';
export 'src/models/people/person_tagged_images.dart';
export 'src/models/people/person_translations.dart';
export 'src/models/reviews/review_details.dart';
export 'src/models/trending_models.dart';
export 'src/utils/tmdb_api_exception.dart';


/// [TmdbApiClient] serves as the central "orchestrator" for interacting with the TMDB API.
/// It manages the client's configuration and provides access to specific API services
/// (like authentication, account details, etc.).
///
/// It does NOT directly perform HTTP requests; instead, it delegates this task
/// to an internal [TmdbApiConnection] instance.
class TmdbApiClient {
  // The core component responsible for executing actual HTTP requests.
  // This is initialized once and shared with all services.
  final TmdbApiConnection _apiConnection;

  // Public getters to access the different services.
  // 'late final' ensures they are initialized once in the constructor.
  late final AuthenticationService authentication;
  late final AccountService account;
  late final CertificationsService certifications;
  late final ChangesService changes;
  late final CollectionsService collections;
  late final CompaniesService companies;
  late final ConfigurationService configuration;
  late final CreditsService credits;
  late final DiscoverService discover;
  late final FindService find;
  late final GenresService genres;
  late final GuestSessionsService guestSessions;
  late final KeywordsService keywords;
  late final ListsService lists;
  late final MoviesService movies;
  late final NetworksService networks;
  late final PeopleService people;
  late final ReviewsService reviews;
  late final TrendingService trending;
  late final SearchService search;
  late final TvService tv;

  /// Constructor for [TmdbApiClient].
  ///
  /// [config] is the initial configuration for the API client (e.g., API key, language).
  /// [httpClient] can be optionally provided for testing purposes (e.g., a MockClient),
  /// and will be passed to the internal [TmdbApiConnection].
  TmdbApiClient({
    required TmdbApiClientConfig config,
    http.Client? httpClient,
  }) : _apiConnection = TmdbApiConnection(config: config, httpClient: httpClient) { // <--- UPDATED: Use TmdbApiConnection
    // Initialize all currently included services, passing them this client instance.
    // Services need a reference to TmdbApiClient to access the _apiConnection and its config.
    authentication = AuthenticationService(this);
    account = AccountService(this);
    certifications = CertificationsService(this);
    changes = ChangesService(this);
    collections = CollectionsService(this);
    companies = CompaniesService(this);
    configuration = ConfigurationService(this);
    credits = CreditsService(this);
    discover = DiscoverService(this);
    find = FindService(this);
    genres = GenresService(this);
    guestSessions = GuestSessionsService(this);
    keywords = KeywordsService(this);
    lists = ListsService(this);
    movies = MoviesService(this);
    networks = NetworksService(this);
    people = PeopleService(this);
    reviews = ReviewsService(this);
    trending = TrendingService(this);
    search = SearchService(this);
    tv = TvService(this);
  }

  /// Public getter to access the current configuration of the client.
  /// This configuration is held and managed by the internal [TmdbApiConnection].
  TmdbApiClientConfig get config => _apiConnection.config;

  /// Allows updating the client's configuration.
  /// This method delegates the update to the internal [TmdbApiConnection],
  /// ensuring all subsequent requests use the updated configuration (e.g., new sessionId).
  void updateConfig(TmdbApiClientConfig newConfig) {
    _apiConnection.updateConfig(newConfig);
  }

  /// Internal helper to execute GET requests via the API connection.
  Future<Map<String, dynamic>> get(String path, {Map<String, String>? queryParameters}) {
    return _apiConnection.get(path, queryParameters: queryParameters);
  }

  /// Internal helper to execute POST requests via the API connection.
  Future<Map<String, dynamic>> post(String path, {Map<String, dynamic>? body, Map<String, String>? queryParameters}) {
    return _apiConnection.post(path, body: body, queryParameters: queryParameters);
  }

  /// Internal helper to execute DELETE requests via the API connection.
  Future<Map<String, dynamic>> delete(String path, {Map<String, dynamic>? body, Map<String, String>? queryParameters}) {
    return _apiConnection.delete(path, body: body, queryParameters: queryParameters);
  }

  /// Closes the underlying HTTP client managed by the API connection.
  ///
  /// It's crucial to call this method when the [TmdbApiClient] instance is no longer
  /// needed to release system resources.
  void close() {
    _apiConnection.close();
  }
}
