import 'dart:io';
import 'package:tmdb_api_client/tmdb_api_client.dart';

/// Main entry point for the package example.
void main() async {
  // --- IMPORTANT: Replace with your actual TMDB API Key (v3) ---
  const String apiKey = 'YOUR_TMDB_API_KEY';

  if (apiKey == 'YOUR_TMDB_API_KEY') {
    print('ERROR: Please replace "YOUR_TMDB_API_KEY" with your real API key.');
    return;
  }

  // Initialize the client with English as the default language for the example.
  final config = TmdbApiClientConfig(apiKey: apiKey, language: 'en-US');
  final tmdbClient = TmdbApiClient(config: config);

  try {
    print('\n--- API Key Validation ---');
    final isKeyValid = await tmdbClient.authentication.validateKey();
    if (!isKeyValid) {
      print('🛑 Error: Your API key is invalid.');
      return;
    }
    print('✅ API Key is valid.');

    print('\n--- Authentication Demonstration ---');

    // Choice of authentication method
    print('Select authentication method:');
    print('1. Standard (via web browser approval)');
    print('2. Login (via username and password - NOT RECOMMENDED for production)');
    stdout.write('Enter your choice (1 or 2): ');
    final choice = stdin.readLineSync();

    Session? session;

    if (choice == '2') {
      // --- Authentication via Login ---
      stdout.write('Enter your TMDB username: ');
      final username = stdin.readLineSync() ?? '';
      stdout.write('Enter your TMDB password: ');
      final password = stdin.readLineSync() ?? '';

      print('\nStep 1: Getting Request Token...');
      final requestToken = await tmdbClient.authentication.createRequestToken();

      print('Step 2: Validating token with login...');
      await tmdbClient.authentication.validateWithLogin(
        username: username,
        password: password,
        requestToken: requestToken.requestToken,
      );

      print('Step 3: Creating session...');
      session = await tmdbClient.authentication.createSession(requestToken.requestToken);
    } else {
      // --- Standard Authentication ---
      final requestToken = await tmdbClient.authentication.createRequestToken();
      print('✅ Request Token obtained: ${requestToken.requestToken}');

      final approveUrl = 'https://www.themoviedb.org/authenticate/${requestToken.requestToken}';
      print('\n🔗 Open this link to approve the token: $approveUrl');
      print('Press Enter AFTER approving in your browser...');
      stdin.readLineSync();

      session = await tmdbClient.authentication.createSession(requestToken.requestToken);
    }

    print('✅ Session created: ${session.sessionId}');

    // 4. Get Account Details
    final account = await tmdbClient.account.getDetails();
    print('\n--- Account Details ---');
    print('ID: ${account.id}, Username: ${account.username}');

    final accountId = account.id;

    // 5. Demonstrate AccountService methods
    print('\n--- Working with Account Lists ---');

    print('Adding movie to favorites...');
    final favSuccess = await tmdbClient.account.markAsFavorite(
      accountId: accountId,
      mediaType: MediaType.movie,
      mediaId: 27205,
      favorite: true,
    );
    print('✅ Status: ${favSuccess ? "Success" : "Failure"}');

    final favoriteMovies = await tmdbClient.account.getFavoriteMovies(accountId: accountId);
    print('Movies found: ${favoriteMovies.totalResults}');
    for (var movie in favoriteMovies.results.take(3)) {
      print(' - ${movie.title} (Rating: ${movie.voteAverage})');
    }

    // 6. Demonstrate CertificationsService
    print('\n--- Working with Certifications ---');
    final certifications = await tmdbClient.certifications.getMovieCertifications();
    final usCerts = certifications.certifications['US'];
    if (usCerts != null) {
      print('US Movie Certifications (Top 5):');
      for (var cert in usCerts.take(5)) {
        print(' - ${cert.certification}: ${cert.meaning}');
      }
    }

    // 7. Demonstrate ChangesService
    print('\n--- Working with Changes ---');
    final movieChanges = await tmdbClient.changes.getMovieChanges();
    print('Recent movie changes found: ${movieChanges.totalResults}');

    // 8. Demonstrate CollectionsService
    print('\n--- Working with Collections ---');
    const collectionId = 10; // Star Wars Collection
    final collection = await tmdbClient.collections.getDetails(collectionId);
    print('Collection Name: ${collection.name}');
    for (var part in collection.parts.take(3)) {
      print(' - ${part.title} (${part.releaseDate})');
    }

    // 9. Demonstrate CompaniesService
    print('\n--- Working with Companies ---');
    const companyId = 1; // Lucasfilm
    final company = await tmdbClient.companies.getDetails(companyId);
    print('Company Name: ${company.name}');
    final logos = await tmdbClient.companies.getLogos(companyId);
    print('Logos found: ${logos.results.length}');

    // 10. Demonstrate ConfigurationService
    print('\n--- Working with Configuration ---');
    final apiConfig = await tmdbClient.configuration.getDetails();
    print('Image Base URL: ${apiConfig.secureBaseUrl}');

    // 11. Demonstrate CreditsService
    print('\n--- Working with Credits ---');
    const creditId = '52fe422dc3a36847f800a747';
    final credit = await tmdbClient.credits.getDetails(creditId);
    print('Person: ${credit.person.name} in ${credit.media.displayName}');

    // 12. Demonstrate DiscoverService
    print('\n--- Working with Discover ---');
    final discoveredMovies = await tmdbClient.discover.movie(
      primaryReleaseYear: 2023,
      sortBy: 'vote_average.desc',
    );
    print('Movies discovered: ${discoveredMovies.totalResults}');

    // 13. Demonstrate FindService
    print('\n--- Working with Find ---');
    const imdbId = 'tt0137523';
    final findResults = await tmdbClient.find.byExternalId(imdbId, externalSource: ExternalSource.imdbId);
    if (findResults.movieResults.isNotEmpty) {
      print('✅ Found Movie: ${findResults.movieResults.first.title}');
    }

    // 14. Demonstrate GenresService
    print('\n--- Working with Genres ---');
    final movieGenres = await tmdbClient.genres.getMovieList();
    print('Sample genres: ${movieGenres.genres.take(3).map((e) => e.name).join(', ')}');

    // 15. Demonstrate Guest Sessions
    print('\n--- Working with Guest Sessions ---');
    final guestSession = await tmdbClient.authentication.createGuestSession();
    if (guestSession.success) {
      print('✅ Guest Session ID: ${guestSession.guestSessionId}');
    }

    // 16. Demonstrate KeywordsService
    print('\n--- Working with Keywords ---');
    const keywordId = 180547;
    final keyword = await tmdbClient.keywords.getDetails(keywordId);
    print('Keyword: ${keyword.name}');

    // 17. Demonstrate ListsService (v3)
    print('\n--- Working with Lists (v3) ---');
    final createListResponse = await tmdbClient.lists.create(
      name: 'Example List',
      description: 'Test list.',
    );
    if (createListResponse.success) {
      print('✅ List v3 created with ID: ${createListResponse.listId}');
      await tmdbClient.lists.deleteList(createListResponse.listId.toString());
      print('✅ List v3 deleted.');
    }

    // 18. Demonstrate MoviesService
    print('\n--- Working with Movie Details ---');
    const movieId = 550;
    final movieDetails = await tmdbClient.movies.getDetails(movieId);
    print('Movie: ${movieDetails.title}');
    final movieCredits = await tmdbClient.movies.getCredits(movieId);
    print('Cast: ${movieCredits.cast.take(3).map((e) => e.name).join(', ')}');

    // 19. Demonstrate NetworksService
    print('\n--- Working with Networks ---');
    const networkId = 49;
    final network = await tmdbClient.networks.getDetails(networkId);
    print('Network: ${network.name}');

    // 20. Demonstrate PeopleService
    print('\n--- Working with Person Details ---');
    const personId = 287;
    final personDetails = await tmdbClient.people.getDetails(personId);
    print('Person: ${personDetails.name}');

    // 21. Demonstrate ReviewsService
    print('\n--- Working with Reviews ---');
    const reviewId = '586829b49251414fd80479ad';
    final review = await tmdbClient.reviews.getDetails(reviewId);
    print('Review by: ${review.author}');

    // 22. Demonstrate TrendingService
    print('\n--- Working with Trending ---');
    final trendingMovies = await tmdbClient.trending.getMovies(TimeWindow.day);
    if (trendingMovies.results.isNotEmpty) {
      print('Trending today: ${trendingMovies.results.first.title}');
    }

    // 23. Demonstrate SearchService
    print('\n--- Working with Search ---');
    final movieSearch = await tmdbClient.search.movie(query: 'Batman');
    print('Search results: ${movieSearch.totalResults}');

    // 24. Demonstrate WatchProvidersService
    print('\n--- Working with Watch Providers ---');
    final regions = await tmdbClient.watchProviders.getAvailableRegions();
    print('Regions available: ${regions.length}');

    // 25. Demonstrate TvSeasonsService
    print('\n--- Working with TV Seasons ---');
    const seriesId = 100088;
    final seasonDetails = await tmdbClient.tvSeasons.getDetails(seriesId, 1);
    print('Season: ${seasonDetails.name}, Episodes: ${seasonDetails.episodes.length}');

    // 26. Demonstrate TvEpisodesService
    print('\n--- Working with TV Episodes ---');
    final episodeDetails = await tmdbClient.tvEpisodes.getDetails(seriesId, 1, 1);
    print('Episode: ${episodeDetails.name}');

    // 28. Demonstrate TMDB API v4
    if (config.accessTokenV4 != null) {
      print('\n--- Working with TMDB API v4 ---');
      final v4Lists = await tmdbClient.v4.account.getLists('ACCOUNT_ID');
      print('User lists v4: ${v4Lists.totalResults}');
    }

    // --- Cleanup ---
    print('\n--- Cleaning Up ---');
    if (session.sessionId.isNotEmpty) {
      await tmdbClient.authentication.deleteSession(session.sessionId);
      print('✅ Session deleted.');
    }

  } on TmdbApiException catch (e) {
    print('🛑 API Error: ${e.message} (Status: ${e.statusCode})');
  } on TmdbNetworkException catch (e) {
    print('🌐 Network Error: ${e.message}');
  } finally {
    tmdbClient.close();
    print('Client closed.');
  }
}
