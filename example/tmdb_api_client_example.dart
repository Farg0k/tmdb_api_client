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
      final password = stdin.readLineSync() ?? ''; // Note: stdin shows characters as typed

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
      // 1. Get Request Token
      final requestToken = await tmdbClient.authentication.createRequestToken();
      print('✅ Request Token obtained: ${requestToken.requestToken}');

      // 2. Approve Token
      final approveUrl = 'https://www.themoviedb.org/authenticate/${requestToken.requestToken}';
      print('\n🔗 Open this link to approve the token: $approveUrl');
      print('Press Enter AFTER approving in your browser...');
      stdin.readLineSync();

      // 3. Create Session
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

    // Mark as favorite (example: "Inception" ID: 27205)
    print('Adding movie to favorites...');
    final favSuccess = await tmdbClient.account.markAsFavorite(
      accountId: accountId,
      mediaType: MediaType.movie,
      mediaId: 27205,
      favorite: true,
    );
    print('✅ Status: ${favSuccess ? "Success" : "Failure"}');

    // Add to watchlist (example: "The Last of Us" ID: 100088)
    print('Adding TV show to watchlist...');
    final wlSuccess = await tmdbClient.account.addToWatchlist(
      accountId: accountId,
      mediaType: MediaType.tv,
      mediaId: 100088,
      watchlist: true,
    );
    print('✅ Status: ${wlSuccess ? "Success" : "Failure"}');

    // Fetch favorite movies
    print('\nFetching favorite movies...');
    final favoriteMovies = await tmdbClient.account.getFavoriteMovies(accountId: accountId);
    print('Movies found: ${favoriteMovies.totalResults}');
    for (var movie in favoriteMovies.results) {
      print(' - ${movie.title} (Rating: ${movie.voteAverage})');
    }

    // Fetch watchlist TV shows
    print('\nFetching watchlist for TV shows...');
    final watchlistTv = await tmdbClient.account.getWatchlistTvShows(accountId: accountId);
    print('TV shows found: ${watchlistTv.totalResults}');
    for (var tv in watchlistTv.results) {
      print(' - ${tv.name} (Air Date: ${tv.firstAirDate})');
    }

    // Fetch rated movies
    print('\nFetching rated movies...');
    final ratedMovies = await tmdbClient.account.getRatedMovies(accountId: accountId);
    print('Movies rated: ${ratedMovies.totalResults}');

    // 6. Demonstrate CertificationsService
    print('\n--- Working with Certifications ---');
    print('Fetching movie certifications...');
    final certifications = await tmdbClient.certifications.getMovieCertifications();
    
    // Display US certifications as an example
    final usCerts = certifications.certifications['US'];
    if (usCerts != null) {
      print('US Movie Certifications:');
      for (var cert in usCerts.take(5)) {
        print(' - ${cert.certification}: ${cert.meaning}');
      }
    }

    // Display UA certifications as another example
    final uaCerts = certifications.certifications['UA'];
    if (uaCerts != null) {
      print('\nUA Movie Certifications:');
      for (var cert in uaCerts) {
        print(' - ${cert.certification}: ${cert.meaning}');
      }
    }

    // 7. Demonstrate ChangesService
    print('\n--- Working with Changes ---');
    print('Fetching recent movie changes (past 24h)...');
    final movieChanges = await tmdbClient.changes.getMovieChanges();
    print('Recent movie changes found: ${movieChanges.totalResults}');
    if (movieChanges.results.isNotEmpty) {
      print('First change ID: ${movieChanges.results.first.id}');
    }

    print('\nFetching recent people changes (past 24h)...');
    final peopleChanges = await tmdbClient.changes.getPeopleChanges();
    print('Recent people changes found: ${peopleChanges.totalResults}');

    // 8. Demonstrate CollectionsService
    print('\n--- Working with Collections ---');
    const collectionId = 10; // Star Wars Collection
    print('Fetching details for Star Wars Collection (ID: $collectionId)...');
    final collection = await tmdbClient.collections.getDetails(collectionId);
    print('Collection Name: ${collection.name}');
    print('Number of movies in collection: ${collection.parts.length}');
    for (var part in collection.parts) {
      print(' - ${part.title} (${part.releaseDate})');
    }

    print('\nFetching images for the collection...');
    final images = await tmdbClient.collections.getImages(collectionId);
    print('Posters found: ${images.posters.length}');
    print('Backdrops found: ${images.backdrops.length}');

    print('\nFetching translations for the collection...');
    final translations = await tmdbClient.collections.getTranslations(collectionId);
    print('Translations available: ${translations.translations.length}');
    if (translations.translations.isNotEmpty) {
      print('First translation language: ${translations.translations.first.englishName}');
    }

    // 9. Demonstrate CompaniesService
    print('\n--- Working with Companies ---');
    const companyId = 1; // Lucasfilm
    print('Fetching details for Lucasfilm (ID: $companyId)...');
    final company = await tmdbClient.companies.getDetails(companyId);
    print('Company Name: ${company.name}');
    print('Headquarters: ${company.headquarters}');
    print('Homepage: ${company.homepage}');

    print('\nFetching alternative names for the company...');
    final altNames = await tmdbClient.companies.getAlternativeNames(companyId);
    print('Alternative names found: ${altNames.results.length}');
    for (var name in altNames.results) {
      print(' - ${name.name} (${name.type})');
    }

    print('\nFetching logos for the company...');
    final logos = await tmdbClient.companies.getLogos(companyId);
    print('Logos found: ${logos.logos.length}');

    // 10. Delete session
    print('\n--- Cleaning Up ---');
    await tmdbClient.authentication.deleteSession(session.sessionId);
    print('✅ Session deleted.');

  } on TmdbApiException catch (e) {
    print('🛑 API Error: ${e.message} (Status: ${e.statusCode})');
  } on TmdbNetworkException catch (e) {
    print('🌐 Network Error: ${e.message}');
  } finally {
    tmdbClient.close();
    print('Client closed.');
  }
}
