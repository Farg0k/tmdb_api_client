import 'package:http/http.dart' as http;

// Core components
import 'src/core/tmdb_api_connection.dart';
import 'src/core/tmdb_api_connection_v4.dart';

// Models
import 'src/models/tmdb_api_client_config.dart';

// Services
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
import 'src/services/v4/auth_v4_service.dart';

// Exports
export 'src/models/tmdb_api_client_config.dart';
export 'src/models/authentication_models.dart';
export 'src/models/account_models.dart';
export 'src/models/media_models.dart';
export 'src/models/certification_models.dart';
export 'src/models/enums.dart';
export 'src/models/change_models.dart';
export 'src/models/collection_models.dart';
export 'src/models/collections/collection_summary.dart';
export 'src/models/configuration_models.dart';
export 'src/models/credit_models.dart';
export 'src/models/find_models.dart';
export 'src/models/genre_models.dart';
export 'src/models/keyword_models.dart';
export 'src/models/list_models.dart';
export 'src/models/movies/movie_details.dart';
export 'src/models/movies/movie_release_dates.dart';
export 'src/models/people/person_summary.dart';
export 'src/models/people/person_details.dart';
export 'src/models/people/person_tagged_images.dart';
export 'src/models/tv/tv_details.dart';
export 'src/models/tv/tv_aggregate_credits.dart';
export 'src/models/tv/tv_content_ratings.dart';
export 'src/models/tv/tv_screened_theatrically.dart';
export 'src/models/tv/tv_episode_summary.dart';
export 'src/models/tv/tv_season_summary.dart';
export 'src/models/tv/seasons/tv_season_details.dart';
export 'src/models/tv/episode_groups/tv_episode_group_details.dart';
export 'src/models/v4/tmdb_v4_list_details.dart';
export 'src/models/v4/tmdb_v4_list_item.dart';
export 'src/models/v4/tmdb_v4_list_create_response.dart';
export 'src/models/v4/tmdb_v4_list_operation_response.dart';
export 'src/models/v4/tmdb_v4_list_item_status.dart';
export 'src/models/v4/tmdb_v4_list_summary.dart';
export 'src/models/v4/tmdb_v4_account_lists_response.dart';
export 'src/models/common/media_account_states.dart';
export 'src/models/common/alternative_title.dart';
export 'src/models/common/tmdb_external_ids.dart';
export 'src/models/common/tmdb_list_response.dart';
export 'src/models/common/tmdb_video.dart';
export 'src/models/common/tmdb_image.dart';
export 'src/models/common/tmdb_review.dart';
export 'src/models/common/tmdb_logo.dart';
export 'src/models/common/tmdb_company.dart';
export 'src/models/common/tmdb_country.dart';
export 'src/models/common/tmdb_language.dart';
export 'src/models/common/tmdb_credit.dart';
export 'src/models/common/tmdb_timezone.dart';
export 'src/models/common/tmdb_watch_provider.dart';
export 'src/models/common/tmdb_business_details.dart';
export 'src/models/common/alternative_name.dart';
export 'src/services/v4/lists_v4_service.dart' show TmdbV4InputItem;
export 'src/models/reviews/review_details.dart';
export 'src/models/trending_models.dart';
export 'src/utils/tmdb_api_exception.dart';

/// The main client for interacting with The Movie Database (TMDB) API.
///
/// This client provides access to both v3 and v4 endpoints through specialized services.
/// It handles authentication, request signing, and data modeling.
class TmdbApiClient {
  /// Internal connection for v3 API requests.
  final TmdbApiConnection _apiConnection;

  /// Internal connection for v4 API requests.
  final TmdbApiConnectionV4 _apiConnectionV4;

  /// Service for authentication-related tasks (Request Tokens, Sessions, Guest Sessions).
  late final AuthenticationService authentication;

  /// Service for account-related tasks (Favorites, Watchlists, Ratings, Lists).
  late final AccountService account;

  /// Service for certifications (Movie and TV).
  late final CertificationsService certifications;

  /// Service for resource changes (Movie, TV, Person).
  late final ChangesService changes;

  /// Service for collections (Movie sets).
  late final CollectionsService collections;

  /// Service for production companies.
  late final CompaniesService companies;

  /// Service for API configuration and languages.
  late final ConfigurationService configuration;

  /// Service for individual credits.
  late final CreditsService credits;

  /// Service for media discovery (Movie and TV).
  late final DiscoverService discover;

  /// Service for finding objects by external IDs (IMDB, etc.).
  late final FindService find;

  /// Service for genres (Movie and TV).
  late final GenresService genres;

  /// Service for guest session specific actions.
  late final GuestSessionsService guestSessions;

  /// Service for keyword-related info.
  late final KeywordsService keywords;

  /// Service for v3 Lists management.
  late final ListsService lists;

  /// Service for movie-specific endpoints.
  late final MoviesService movies;

  /// Service for TV networks.
  late final NetworksService networks;

  /// Service for person-specific endpoints (Cast, Crew).
  late final PeopleService people;

  /// Service for user and critic reviews.
  late final ReviewsService reviews;

  /// Service for trending media (Day, Week).
  late final TrendingService trending;

  /// Service for global search (Multi, Movie, TV, Person).
  late final SearchService search;

  /// Service for TV series details.
  late final TvService tv;

  /// Service for TV seasons.
  late final TvSeasonsService tvSeasons;

  /// Service for TV episode groups.
  late final TvEpisodeGroupsService tvEpisodeGroups;

  /// Service for watch providers (Streaming, Rent, Buy).
  late final WatchProvidersService watchProviders;

  /// Service for TV episodes.
  late final TvEpisodesService tvEpisodes;

  /// Access point for TMDB API v4 specific features.
  late final TmdbV4 v4;

  /// Creates a new [TmdbApiClient] instance.
  ///
  /// [config] contains the API keys and default settings.
  /// [httpClient] is an optional custom HTTP client (useful for testing or advanced configuration).
  TmdbApiClient({required TmdbApiClientConfig config, http.Client? httpClient})
    : _apiConnection = TmdbApiConnection(
        config: config,
        httpClient: httpClient,
      ),
      _apiConnectionV4 = TmdbApiConnectionV4(
        config: config,
        httpClient: httpClient,
      ) {
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

  /// The current configuration of the client.
  TmdbApiClientConfig get config => _apiConnection.config;

  /// Updates the client configuration at runtime.
  ///
  /// This will update both v3 and v4 connections.
  void updateConfig(TmdbApiClientConfig newConfig) {
    _apiConnection.updateConfig(newConfig);
    _apiConnectionV4.updateConfig(newConfig);
  }

  /// Performs a low-level GET request to the TMDB API v3.
  Future<dynamic> get(
    String path, {
    Map<String, String>? queryParameters,
  }) {
    return _apiConnection.get(path, queryParameters: queryParameters);
  }

  /// Performs a low-level POST request to the TMDB API v3.
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) {
    return _apiConnection.post(
      path,
      body: body,
      queryParameters: queryParameters,
    );
  }

  /// Performs a low-level DELETE request to the TMDB API v3.
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) {
    return _apiConnection.delete(
      path,
      body: body,
      queryParameters: queryParameters,
    );
  }

  /// Closes the client and all associated connections.
  void close() {
    _apiConnection.close();
    _apiConnectionV4.close();
  }
}

/// Entry point for TMDB API v4 features.
class TmdbV4 {
  /// Service for v4 Lists management.
  late final ListsV4Service lists;

  /// Service for v4 Account-related data.
  late final AccountV4Service account;

  /// Service for v4 Authentication.
  late final AuthV4Service auth;

  TmdbV4(TmdbApiClient client, TmdbApiConnectionV4 connection) {
    lists = ListsV4Service(client, connection);
    account = AccountV4Service(client, connection);
    auth = AuthV4Service(client, connection);
  }
}
