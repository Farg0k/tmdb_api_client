import 'dart:io';
import 'package:tmdb_api_client/tmdb_api_client.dart';
import 'package:logging/logging.dart';

/// Main entry point for the package example.
void main() async {
  // Configure logging
  Logger.root.level = Level.ALL;
  final log = Logger('TmdbExample');
  Logger.root.onRecord.listen((record) {
    log.info('${record.level.name}: ${record.time}: ${record.message}');
  });

  // --- IMPORTANT: Replace with your actual TMDB API Key (v3) ---
  const String apiKey = 'YOUR_TMDB_API_KEY';

  if (apiKey == 'YOUR_TMDB_API_KEY') {
    log.severe('Please replace "YOUR_TMDB_API_KEY" with your real API key.');
    return;
  }

  // Initialize the client with English as the default language for the example.
  final config = TmdbApiClientConfig(apiKey: apiKey, language: 'en-US');
  final tmdbClient = TmdbApiClient(config: config);

  try {
    log.info('--- API Key Validation ---');
    final isKeyValid = await tmdbClient.authentication.validateKey();
    if (!isKeyValid) {
      log.severe('Your API key is invalid.');
      return;
    }
    log.info('API Key is valid.');

    log.info('--- Authentication Demonstration ---');

    log.info('Select authentication method:');
    log.info('1. Standard (via web browser approval)');
    log.info(
      '2. Login (via username and password - NOT RECOMMENDED for production)',
    );
    stdout.write('Enter your choice (1 or 2): ');
    final choice = stdin.readLineSync();

    Session? session;

    if (choice == '2') {
      stdout.write('Enter your TMDB username: ');
      final username = stdin.readLineSync() ?? '';
      stdout.write('Enter your TMDB password: ');
      final password = stdin.readLineSync() ?? '';

      log.info('Getting Request Token...');
      final requestToken = await tmdbClient.authentication.createRequestToken();

      log.info('Validating token with login...');
      await tmdbClient.authentication.validateWithLogin(
        username: username,
        password: password,
        requestToken: requestToken.requestToken,
      );

      log.info('Creating session...');
      session = await tmdbClient.authentication.createSession(
        requestToken.requestToken,
      );
    } else {
      final requestToken = await tmdbClient.authentication.createRequestToken();
      log.info('Request Token: ${requestToken.requestToken}');

      final approveUrl =
          'https://www.themoviedb.org/authenticate/${requestToken.requestToken}';
      log.info('Open this link to approve the token: $approveUrl');
      log.info('Press Enter AFTER approving in your browser...');
      stdin.readLineSync();

      session = await tmdbClient.authentication.createSession(
        requestToken.requestToken,
      );
    }

    log.info('Session created: ${session.sessionId}');

    final account = await tmdbClient.account.getDetails();
    log.info(
      'Account Details: ID: ${account.id}, Username: ${account.username}',
    );

    final accountId = account.id;

    log.info('Working with Account Lists...');
    final favSuccess = await tmdbClient.account.markAsFavorite(
      accountId: accountId,
      mediaType: TmdbMediaType.movie,
      mediaId: 27205,
      favorite: true,
    );
    log.info('Favorite status: ${favSuccess ? "Success" : "Failure"}');

    final favoriteMovies = await tmdbClient.account.getFavoriteMovies(
      accountId: accountId,
      sortBy: AccountSortBy.createdAtDesc,
    );
    log.info('Movies found: ${favoriteMovies.totalResults}');
    for (var movie in favoriteMovies.results.take(3)) {
      log.info(' - ${movie.title} (Rating: ${movie.voteAverage})');
    }

    log.info('Working with Certifications...');
    final certifications = await tmdbClient.certifications
        .getMovieCertifications();
    final usCerts = certifications.certifications['US'];
    if (usCerts != null) {
      log.info('US Movie Certifications (Top 5):');
      for (var cert in usCerts.take(5)) {
        log.info(' - ${cert.certification}: ${cert.meaning}');
      }
    }

    log.info('Working with Changes...');
    final movieChanges = await tmdbClient.changes.getMovieChanges();
    log.info('Recent movie changes found: ${movieChanges.totalResults}');

    log.info('Working with Collections...');
    const collectionId = 10;
    final collection = await tmdbClient.collections.getDetails(collectionId);
    log.info('Collection Name: ${collection.name}');
    for (var part in collection.parts.take(3)) {
      log.info(' - ${part.title} (${part.releaseDate})');
    }

    log.info('Working with Companies...');
    const companyId = 1;
    final company = await tmdbClient.companies.getDetails(companyId);
    log.info('Company Name: ${company.name}');
    final logos = await tmdbClient.companies.getLogos(companyId);
    log.info('Logos found: ${logos.results.length}');

    log.info('Working with Configuration...');
    final apiConfig = await tmdbClient.configuration.getDetails();
    log.info('Image Base URL: ${apiConfig.secureBaseUrl}');

    log.info('Working with Credits...');
    const creditId = '52fe422dc3a36847f800a747';
    final credit = await tmdbClient.credits.getDetails(creditId);
    log.info('Person: ${credit.person.name} in ${credit.media.displayName}');

    log.info('Working with Discover...');
    final discoveredMovies = await tmdbClient.discover.movie(
      primaryReleaseYear: 2023,
      sortBy: MovieSortBy.voteAverageDesc,
    );
    log.info('Movies discovered: ${discoveredMovies.totalResults}');

    log.info('Working with Find...');
    const imdbId = 'tt0137523';
    final findResults = await tmdbClient.find.byExternalId(
      imdbId,
      externalSource: ExternalSource.imdbId,
    );
    if (findResults.movieResults.isNotEmpty) {
      log.info('Found Movie: ${findResults.movieResults.first.title}');
    }

    log.info('Working with Genres...');
    final movieGenres = await tmdbClient.genres.getMovieList();
    log.info(
      'Sample genres: ${movieGenres.genres.take(3).map((e) => e.name).join(', ')}',
    );

    log.info('Working with Guest Sessions...');
    final guestSession = await tmdbClient.authentication.createGuestSession();
    if (guestSession.success) {
      log.info('Guest Session ID: ${guestSession.guestSessionId}');
    }

    log.info('Working with Keywords...');
    const keywordId = 180547;
    final keyword = await tmdbClient.keywords.getDetails(keywordId);
    log.info('Keyword: ${keyword.name}');

    log.info('Working with Lists (v3)...');
    final createListResponse = await tmdbClient.lists.create(
      name: 'Example List',
      description: 'Test list.',
    );
    if (createListResponse.success) {
      log.info('List v3 created with ID: ${createListResponse.listId}');
      await tmdbClient.lists.deleteList(createListResponse.listId.toString());
      log.info('List v3 deleted.');
    }

    log.info('Working with Movie Details...');
    const movieId = 550;
    final movieDetails = await tmdbClient.movies.getDetails(movieId);
    log.info('Movie: ${movieDetails.title}');
    final movieCredits = await tmdbClient.movies.getCredits(movieId);
    log.info(
      'Cast: ${movieCredits.cast.take(3).map((e) => e.name).join(', ')}',
    );

    log.info('Working with Networks...');
    const networkId = 49;
    final network = await tmdbClient.networks.getDetails(networkId);
    log.info('Network: ${network.name}');

    log.info('Working with Person Details...');
    const personId = 287;
    final personDetails = await tmdbClient.people.getDetails(personId);
    log.info('Person: ${personDetails.name}');

    log.info('Working with Reviews...');
    const reviewId = '586829b49251414fd80479ad';
    final review = await tmdbClient.reviews.getDetails(reviewId);
    log.info('Review by: ${review.author}');

    log.info('Working with Trending...');
    final trendingMovies = await tmdbClient.trending.getMovies(TimeWindow.day);
    if (trendingMovies.results.isNotEmpty) {
      log.info('Trending today: ${trendingMovies.results.first.title}');
    }

    log.info('Working with Search...');
    final movieSearch = await tmdbClient.search.movie(query: 'Batman');
    log.info('Search results: ${movieSearch.totalResults}');

    log.info('Working with Watch Providers...');
    final regions = await tmdbClient.watchProviders.getAvailableRegions();
    log.info('Regions available: ${regions.length}');

    log.info('Working with TV Seasons...');
    const seriesId = 100088;
    final seasonDetails = await tmdbClient.tvSeasons.getDetails(seriesId, 1);
    log.info(
      'Season: ${seasonDetails.name}, Episodes: ${seasonDetails.episodes.length}',
    );

    log.info('Working with TV Episodes...');
    final episodeDetails = await tmdbClient.tvEpisodes.getDetails(
      seriesId,
      1,
      1,
    );
    log.info('Episode: ${episodeDetails.name}');

    if (config.accessTokenV4 != null) {
      log.info('Working with TMDB API v4...');
      final v4Lists = await tmdbClient.v4.account.getLists('ACCOUNT_ID');
      log.info('User lists v4: ${v4Lists.totalResults}');
    }

    log.info('Cleaning Up...');
    if (session.sessionId.isNotEmpty) {
      await tmdbClient.authentication.deleteSession(session.sessionId);
      log.info('Session deleted.');
    }
  } on TmdbApiException catch (e) {
    log.severe('API Error: ${e.message} (Status: ${e.statusCode})');
  } on TmdbNetworkException catch (e) {
    log.severe('Network Error: ${e.message}');
  } finally {
    tmdbClient.close();
    log.info('Client closed.');
  }
}
