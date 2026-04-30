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
    print('\n--- Authentication Demonstration ---');

    // 1. Get Request Token
    final requestToken = await tmdbClient.authentication.createRequestToken();
    print('✅ Request Token obtained: ${requestToken.requestToken}');

    // 2. Approve Token
    final approveUrl = 'https://www.themoviedb.org/authenticate/${requestToken.requestToken}';
    print('\n🔗 Open this link to approve the token: $approveUrl');
    print('Press Enter AFTER approving in your browser...');
    stdin.readLineSync();

    // 3. Create Session
    final session = await tmdbClient.authentication.createSession(requestToken.requestToken);
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

    // 6. Delete session
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
