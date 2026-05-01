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

    // 10. Demonstrate ConfigurationService
    print('\n--- Working with Configuration ---');
    print('Fetching API configuration details...');
    final apiConfig = await tmdbClient.configuration.getDetails();
    print('Image Base URL: ${apiConfig.secureBaseUrl}');
    print('Poster Sizes: ${apiConfig.posterSizes.join(', ')}');

    print('\nFetching supported countries...');
    final countries = await tmdbClient.configuration.getCountries();
    print('Number of countries: ${countries.length}');
    print('First 5 countries: ${countries.take(5).map((e) => e.englishName).join(', ')}');

    print('\nFetching supported languages...');
    final languages = await tmdbClient.configuration.getLanguages();
    print('Number of languages: ${languages.length}');

    // 11. Demonstrate CreditsService
    print('\n--- Working with Credits ---');
    const creditId = '52fe422dc3a36847f800a747'; // Mark Hamill in Star Wars
    print('Fetching credit details for Mark Hamill (ID: $creditId)...');
    final credit = await tmdbClient.credits.getDetails(creditId);
    print('Person: ${credit.person.name}');
    print('Media: ${credit.media.displayName}');
    print('Job/Role: ${credit.job.isNotEmpty ? credit.job : credit.media.character}');

    // 12. Demonstrate DiscoverService
    print('\n--- Working with Discover ---');
    print('Discovering top rated movies of 2023...');
    final discoveredMovies = await tmdbClient.discover.movie(
      primaryReleaseYear: 2023,
      sortBy: 'vote_average.desc',
      queryParameters: {
        'vote_count.gte': '500',
      },
    );
    print('Movies discovered: ${discoveredMovies.totalResults}');
    for (var movie in discoveredMovies.results.take(3)) {
      print(' - ${movie.title} (Rating: ${movie.voteAverage})');
    }

    print('\nDiscovering popular TV shows in English...');
    final discoveredTv = await tmdbClient.discover.tv(
      sortBy: 'popularity.desc',
      queryParameters: {
        'with_original_language': 'en',
      },
    );
    print('TV shows discovered: ${discoveredTv.totalResults}');

    // 13. Demonstrate FindService
    print('\n--- Working with Find ---');
    const imdbId = 'tt0137523'; // Fight Club
    print('Finding media by IMDb ID: $imdbId...');
    final findResults = await tmdbClient.find.byExternalId(
      imdbId,
      externalSource: ExternalSource.imdbId,
    );
    if (findResults.movieResults.isNotEmpty) {
      final movie = findResults.movieResults.first;
      print('✅ Found Movie: ${movie.title} (Released: ${movie.releaseDate})');
    }

    // 14. Demonstrate GenresService
    print('\n--- Working with Genres ---');
    print('Fetching movie genres...');
    final movieGenres = await tmdbClient.genres.getMovieList();
    print('Movie genres found: ${movieGenres.genres.length}');
    print('Sample genres: ${movieGenres.genres.take(5).map((e) => e.name).join(', ')}');

    print('\nFetching TV genres...');
    final tvGenres = await tmdbClient.genres.getTvList();
    print('TV genres found: ${tvGenres.genres.length}');

    // 15. Demonstrate GuestSessionsService
    print('\n--- Working with Guest Sessions ---');
    print('Creating a guest session...');
    final guestSession = await tmdbClient.authentication.createGuestSession();
    if (guestSession.success) {
      print('✅ Guest Session ID: ${guestSession.guestSessionId}');
      
      print('Fetching rated movies for guest session (will be empty for new session)...');
      final ratedMovies = await tmdbClient.guestSessions.getRatedMovies(guestSession.guestSessionId);
      print('Rated movies found: ${ratedMovies.totalResults}');
    }

    // 16. Demonstrate KeywordsService
    print('\n--- Working with Keywords ---');
    const keywordId = 180547; // "marvel cinematic universe (mcu)"
    print('Fetching details for keyword: MCU (ID: $keywordId)...');
    final keyword = await tmdbClient.keywords.getDetails(keywordId);
    print('Keyword Name: ${keyword.name}');

    print('\nFetching movies for this keyword...');
    final keywordMovies = await tmdbClient.keywords.getMovies(keywordId);
    print('Movies found with this keyword: ${keywordMovies.totalResults}');
    for (var movie in keywordMovies.results.take(3)) {
      print(' - ${movie.title}');
    }

    // 17. Demonstrate ListsService
    print('\n--- Working with Lists ---');
    print('Creating a new list "My Awesome Movies"...');
    final createListResponse = await tmdbClient.lists.create(
      name: 'My Awesome Movies',
      description: 'A list of movies I really like.',
    );
    if (createListResponse.success) {
      final listId = createListResponse.listId.toString();
      print('✅ List created with ID: $listId');

      print('Adding "Fight Club" (ID: 550) to the list...');
      await tmdbClient.lists.addMovie(listId, 550);

      print('Checking if "Fight Club" is in the list...');
      final isPresent = await tmdbClient.lists.checkItemStatus(listId, 550);
      print('✅ Is present: $isPresent');

      print('Fetching list details...');
      final listDetails = await tmdbClient.lists.getDetails(listId);
      print('List Name: ${listDetails.name}');
      print('Items in list: ${listDetails.itemCount}');

      print('Deleting the list...');
      await tmdbClient.lists.deleteList(listId);
      print('✅ List deleted.');
    }

    // 18. Demonstrate MoviesService (Movie Lists)
    print('\n--- Working with Movie Lists ---');
    print('Fetching popular movies...');
    final popularMovies = await tmdbClient.movies.getPopular();
    print('Popular movies found: ${popularMovies.totalResults}');
    for (var movie in popularMovies.results.take(3)) {
      print(' - ${movie.title} (Popularity: ${movie.voteAverage})');
    }

    print('\nFetching movies now playing in theatres...');
    final nowPlaying = await tmdbClient.movies.getNowPlaying();
    print('Movies now playing: ${nowPlaying.totalResults}');

    // 19. Demonstrate NetworksService
    print('\n--- Working with Networks ---');
    const networkId = 49; // HBO
    print('Fetching details for HBO (ID: $networkId)...');
    final network = await tmdbClient.networks.getDetails(networkId);
    print('Network Name: ${network.name}');
    print('Headquarters: ${network.headquarters}');

    print('\nFetching logos for the network...');
    final networkLogos = await tmdbClient.networks.getLogos(networkId);
    print('Logos found: ${networkLogos.logos.length}');

    // 20. Demonstrate MoviesService (Details & Credits)
    print('\n--- Working with Movie Details ---');
    const movieId = 550; // Fight Club
    print('Fetching details for Fight Club (ID: $movieId)...');
    final movieDetails = await tmdbClient.movies.getDetails(movieId);
    print('Title: ${movieDetails.title}');
    print('Tagline: ${movieDetails.tagline}');
    print('Runtime: ${movieDetails.runtime} minutes');
    print('Genres: ${movieDetails.genres.map((g) => g.name).join(', ')}');

    print('\nFetching credits for Fight Club...');
    final movieCredits = await tmdbClient.movies.getCredits(movieId);
    print('Cast members: ${movieCredits.cast.length}');
    for (var cast in movieCredits.cast.take(5)) {
      print(' - ${cast.name} as ${cast.character}');
    }

    // 21. Demonstrate PeopleService (Popular People)
    print('\n--- Working with People ---');
    print('Fetching popular people...');
    final popularPeople = await tmdbClient.people.getPopular();
    print('Popular people found: ${popularPeople.totalResults}');
    for (var person in popularPeople.results.take(3)) {
      print(' - ${person.name} (Popularity: ${person.popularity})');
    }

    // 22. Demonstrate PeopleService (Details & Credits)
    print('\n--- Working with Person Details ---');
    const personId = 287; // Brad Pitt
    print('Fetching details for Brad Pitt (ID: $personId)...');
    final personDetails = await tmdbClient.people.getDetails(personId);
    print('Name: ${personDetails.name}');
    print('Birthday: ${personDetails.birthday}');
    print('Place of Birth: ${personDetails.placeOfBirth}');

    print('\nFetching movie credits for Brad Pitt...');
    final personCredits = await tmdbClient.people.getMovieCredits(personId);
    print('Movies as cast: ${personCredits.cast.length}');
    for (var credit in personCredits.cast.take(5)) {
      print(' - ${credit.title} as ${credit.character}');
    }

    // 23. Demonstrate ReviewsService
    print('\n--- Working with Reviews ---');
    const reviewId = '586829b49251414fd80479ad'; // A review for Fight Club
    print('Fetching details for review (ID: $reviewId)...');
    final review = await tmdbClient.reviews.getDetails(reviewId);
    print('Author: ${review.author}');
    print('Media: ${review.mediaTitle}');
    print('Content snippet: ${review.content.substring(0, 100)}...');

    // 24. Demonstrate TrendingService
    print('\n--- Working with Trending ---');
    print('Fetching daily trending movies...');
    final trendingMovies = await tmdbClient.trending.getMovies(TimeWindow.day);
    print('Trending movies found: ${trendingMovies.totalResults}');
    for (var movie in trendingMovies.results.take(3)) {
      print(' - ${movie.title} (Popularity: ${movie.popularity})');
    }

    print('\nFetching weekly trending people...');
    final trendingPeople = await tmdbClient.trending.getPeople(TimeWindow.week);
    print('Trending people found: ${trendingPeople.totalResults}');

    // 25. Demonstrate SearchService
    print('\n--- Working with Search ---');
    print('Searching for "Batman" movies...');
    final movieSearch = await tmdbClient.search.movie(query: 'Batman', year: 2022);
    print('Movies found: ${movieSearch.totalResults}');
    for (var movie in movieSearch.results.take(3)) {
      print(' - ${movie.title} (${movie.releaseDate})');
    }

    print('\nSearching for "Nolan" in People...');
    final personSearch = await tmdbClient.search.person(query: 'Nolan');
    print('People found: ${personSearch.totalResults}');
    for (var person in personSearch.results.take(3)) {
      print(' - ${person.name} (${person.knownForDepartment})');
    }

    // 26. Demonstrate TvService (TV Lists)
    print('\n--- Working with TV Lists ---');
    print('Fetching popular TV shows...');
    final popularTv = await tmdbClient.tv.getPopular();
    print('Popular TV shows found: ${popularTv.totalResults}');
    for (var tv in popularTv.results.take(3)) {
      print(' - ${tv.name} (Rating: ${tv.voteAverage})');
    }

    print('\nFetching TV shows airing today...');
    final airingToday = await tmdbClient.tv.getAiringToday();
    print('TV shows airing today: ${airingToday.totalResults}');

    // 27. Demonstrate TvSeasonsService (TV Seasons)
    print('\n--- Working with TV Seasons ---');
    const seriesIdForSeason = 100088; // The Last of Us
    const seasonNumber = 1;
    print('Fetching details for "The Last of Us" Season $seasonNumber...');
    final seasonDetails = await tmdbClient.tvSeasons.getDetails(seriesIdForSeason, seasonNumber);
    print('Season Name: ${seasonDetails.name}');
    print('Episodes: ${seasonDetails.episodes.length}');
    for (var episode in seasonDetails.episodes.take(3)) {
      print(' - Ep ${episode.episodeNumber}: ${episode.name}');
    }

    print('\nFetching external IDs for the season...');
    final seasonExternalIds = await tmdbClient.tvSeasons.getExternalIds(seriesIdForSeason, seasonNumber);
    print('TVDB ID: ${seasonExternalIds.tvdbId}');

    // 28. Demonstrate TvService (Details & Credits)
    print('\n--- Working with TV Series Details ---');
    const seriesId = 100088; // The Last of Us
    print('Fetching details for "The Last of Us" (ID: $seriesId)...');
    final tvDetails = await tmdbClient.tv.getDetails(seriesId);
    print('Name: ${tvDetails.name}');
    print('Status: ${tvDetails.status}');
    print('Seasons: ${tvDetails.numberOfSeasons}');
    print('Networks: ${tvDetails.networks.map((n) => n.name).join(', ')}');

    print('\nFetching aggregate credits for "The Last of Us"...');
    final aggCredits = await tmdbClient.tv.getAggregateCredits(seriesId);
    print('Cast members: ${aggCredits.cast.length}');
    for (var cast in aggCredits.cast.take(5)) {
      final roles = cast.roles.map((r) => r.character).join(', ');
      print(' - ${cast.name} as $roles (${cast.totalEpisodeCount} episodes)');
    }

    // 29. Delete session
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
