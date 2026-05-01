# TMDB API Client for Dart & Flutter

A comprehensive, high-quality Dart wrapper for The Movie Database (TMDB) API, covering both **v3** and **v4** versions. Designed with a clean, unified architecture and granular models.

[![Pub Version](https://img.shields.io/pub/v/tmdb_api_client)](https://pub.dev/packages/tmdb_api_client)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- **Full TMDB v3 Support**: Movies, TV Shows, People, Search, Discover, Collections, Companies, and more.
- **TMDB v4 Integration**: Auth with Bearer tokens, granular List management, and Account-specific lists.
- **Unified Data Models**: Maximum code reuse with shared models for Images, Videos, Credits, and External IDs.
- **Type-Safe**: Granular models for every response (no more `Map<String, dynamic>` everywhere).
- **Flexible Parameters**: Every official TMDB query parameter is supported as a named argument.
- **Pagination Support**: Easy-to-use `TmdbResponsePage<T>` for all list-based endpoints.
- **Zero Dependencies (besides http)**: Lightweight and performant.

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  tmdb_api_client: ^1.0.0
```

Then run:
```bash
dart pub get
```

## Getting Started

### Initialize the Client

```dart
import 'package:tmdb_api_client/tmdb_api_client.dart';

final config = TmdbApiClientConfig(
  apiKey: 'YOUR_V3_API_KEY',
  accessTokenV4: 'YOUR_V4_ACCESS_TOKEN', // Optional, for v4 features
  language: 'en-US',
);

final tmdb = TmdbApiClient(config: config);
```

### Basic v3 Usage (Movies)

```dart
// Get movie details
final MovieDetails movie = await tmdb.movies.getDetails(550);
print('Title: ${movie.title}');

// Get popular movies (paginated)
final TmdbResponsePage<MovieSummary> popular = await tmdb.movies.getPopular(page: 1);
for (var m in popular.results) {
  print(m.title);
}
```

### Working with TV Shows

```dart
// Get TV series details
final TvDetails series = await tmdb.tv.getDetails(1399); // Game of Thrones
print('Seasons: ${series.numberOfSeasons}');

// Get specific season details
final TvSeasonDetails season = await tmdb.tvSeasons.getDetails(1399, 1);
print('Episodes in Season 1: ${season.episodes.length}');
```

### Unified Credits (Cast & Crew)

Thanks to our unified architecture, credits work the same way across all media types:

```dart
final TmdbCredits credits = await tmdb.movies.getCredits(550);
final firstActor = credits.cast.first;
print('Actor: ${firstActor.name} as ${firstActor.character}');
```

### Search & Discover

```dart
// Search for anything
final searchResults = await tmdb.search.multi(query: 'Inception');

// Complex discovery
final discovery = await tmdb.discover.movie(
  sortBy: 'vote_average.desc',
  year: 2023,
  withGenres: '28,12', // Action & Adventure
);
```

### TMDB v4 Features

```dart
// Manage v4 Lists
final myList = await tmdb.v4.lists.getDetails(12345);
print('List Name: ${myList.name}');

// Add items to a list
await tmdb.v4.lists.addItems(12345, [
  TmdbV4InputItem(mediaId: 550, mediaType: 'movie', comment: 'Great movie!'),
]);
```

## Architecture: "Maximum Unification"

This package uses a unique architecture where common API blocks are unified into shared classes:

- **`TmdbExternalIds`**: Single model for all external links (IMDB, Twitter, etc.).
- **`TmdbCredits`**: Shared cast/crew structure for Movies, TV, and Episodes.
- **`TmdbBusinessDetails`**: Unified model for Production Companies and TV Networks.
- **`TmdbListResponse<T>`**: Standardized wrapper for any list endpoint (Keywords, Alternative Titles, etc.).

## Authentication Methods

1. **API Key (v3)**: Simply pass your `apiKey` to `TmdbApiClientConfig`.
2. **Session ID (v3)**: After user approval, set `config.sessionId` to access account-specific methods.
3. **Access Token (v4)**: Use `accessTokenV4` for all v4 endpoints and modern authentication.

## Additional Information

- **TMDB Documentation**: [https://developer.themoviedb.org/](https://developer.themoviedb.org/)
- **Bug Reports**: Please open an issue on GitHub if you find any discrepancies.
- **Contributions**: Pull requests are welcome!

## License

This project is licensed under the MIT License - see the LICENSE file for details.
