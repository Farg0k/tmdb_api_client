import 'package:http/http.dart' as http; // Alias 'http' for the HTTP client library.

// Core components - the actual HTTP communication layer.
import 'src/core/tmdb_api_connection.dart'; // <--- NEW: Import the API connection class.
import 'src/core/tmdb_api_connection_v4.dart';

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
import 'src/services/tv_seasons_service.dart';
import 'src/services/tv_episode_groups_service.dart';
import 'src/services/watch_providers_service.dart';
import 'src/services/tv_episodes_service.dart';

// V4 Services
import 'src/services/v4/lists_v4_service.dart';
import 'src/services/v4/account_v4_service.dart';

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
export 'src/models/tv/tv_details.dart';
export 'src/models/tv/tv_account_states.dart';
export 'src/models/tv/tv_aggregate_credits.dart';
export 'src/models/tv/tv_alternative_titles.dart';
export 'src/models/tv/tv_content_ratings.dart';
export 'src/models/tv/tv_credits.dart';
export 'src/models/tv/tv_episode_groups.dart';
export 'src/models/tv/tv_external_ids.dart';
export 'src/models/tv/tv_images.dart';
export 'src/models/tv/tv_keywords.dart';
export 'src/models/tv/tv_reviews.dart';
export 'src/models/tv/tv_screened_theatrically.dart';
export 'src/models/tv/tv_translations.dart';
export 'src/models/tv/tv_videos.dart';
export 'src/models/tv/tv_watch_providers.dart';
export 'src/models/tv/tv_episode_summary.dart';
export 'src/models/tv/seasons/tv_season_details.dart';
export 'src/models/tv/seasons/tv_season_account_states.dart';
export 'src/models/tv/seasons/tv_season_external_ids.dart';
export 'src/models/tv/episode_groups/tv_episode_group_details.dart';
export 'src/models/tv/episodes/tv_episode_account_states.dart';
export 'src/models/v4/tmdb_v4_list_models.dart';
export 'src/services/v4/lists_v4_service.dart' show TmdbV4InputItem;
export 'src/models/reviews/review_details.dart';
export 'src/models/trending_models.dart';
export 'src/utils/tmdb_api_exception.dart';


/// [TmdbApiClient] serves as the central "orchestrator" for interacting with the TMDB API.
/// It manages the client's configuration and provides access to specific API services.
class TmdbApiClient {
  final TmdbApiConnection _apiConnection;
  final TmdbApiConnectionV4 _apiConnectionV4;

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
  late final TvSeasonsService tvSeasons;
  late final TvEpisodeGroupsService tvEpisodeGroups;
  late final WatchProvidersService watchProviders;
  late final TvEpisodesService tvEpisodes;

  /// Access to TMDB API v4 services.
  late final TmdbV4 v4;

  TmdbApiClient({
    required TmdbApiClientConfig config,
    http.Client? httpClient,
  })  : _apiConnection = TmdbApiConnection(config: config, httpClient: httpClient),
        _apiConnectionV4 = TmdbApiConnectionV4(config: config, httpClient: httpClient) {
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
    tvSeasons = TvSeasonsService(this);
    tvEpisodeGroups = TvEpisodeGroupsService(this);
    watchProviders = WatchProvidersService(this);
    tvEpisodes = TvEpisodesService(this);

    v4 = TmdbV4(this, _apiConnectionV4);
  }

  TmdbApiClientConfig get config => _apiConnection.config;

  void updateConfig(TmdbApiClientConfig newConfig) {
    _apiConnection.updateConfig(newConfig);
    _apiConnectionV4.updateConfig(newConfig);
  }

  Future<Map<String, dynamic>> get(String path, {Map<String, String>? queryParameters}) {
    return _apiConnection.get(path, queryParameters: queryParameters);
  }

  Future<Map<String, dynamic>> post(String path, {Map<String, dynamic>? body, Map<String, String>? queryParameters}) {
    return _apiConnection.post(path, body: body, queryParameters: queryParameters);
  }

  Future<Map<String, dynamic>> delete(String path, {Map<String, dynamic>? body, Map<String, String>? queryParameters}) {
    return _apiConnection.delete(path, body: body, queryParameters: queryParameters);
  }

  void close() {
    _apiConnection.close();
    _apiConnectionV4.close();
  }
}

/// [TmdbV4] groups all TMDB API v4 services.
class TmdbV4 {
  late final ListsV4Service lists;
  late final AccountV4Service account;

  TmdbV4(TmdbApiClient client, TmdbApiConnectionV4 connection) {
    lists = ListsV4Service(client, connection);
    account = AccountV4Service(client, connection);
  }
}
