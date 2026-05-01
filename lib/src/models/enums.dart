/// Represents certification/age rating levels for movies and TV shows.
enum CertificationLevel {
  g('G'),
  pg('PG'),
  pg13('PG-13'),
  r('R'),
  nc17('NC-17');

  final String value;
  const CertificationLevel(this.value);
}

/// Sort options for movie discovery.
enum MovieSortBy {
  popularityAsc('popularity.asc'),
  popularityDesc('popularity.desc'),
  releaseDateAsc('release_date.asc'),
  releaseDateDesc('release_date.desc'),
  revenueAsc('revenue.asc'),
  revenueDesc('revenue.desc'),
  primaryReleaseDateAsc('primary_release_date.asc'),
  primaryReleaseDateDesc('primary_release_date.desc'),
  originalTitleAsc('original_title.asc'),
  originalTitleDesc('original_title.desc'),
  voteAverageAsc('vote_average.asc'),
  voteAverageDesc('vote_average.desc'),
  voteCountAsc('vote_count.asc'),
  voteCountDesc('vote_count.desc');

  final String value;
  const MovieSortBy(this.value);
}

/// Sort options for TV show discovery.
enum TvSortBy {
  popularityAsc('popularity.asc'),
  popularityDesc('popularity.desc'),
  voteAverageAsc('vote_average.asc'),
  voteAverageDesc('vote_average.desc'),
  firstAirDateAsc('first_air_date.asc'),
  firstAirDateDesc('first_air_date.desc'),
  voteCountAsc('vote_count.asc'),
  voteCountDesc('vote_count.desc');

  final String value;
  const TvSortBy(this.value);
}

/// Types of media releases.
enum ReleaseType {
  cinema('2'),
  digital('4'),
  physical('5'),
  tv('6');

  final String value;
  const ReleaseType(this.value);
}

/// Types of watch provider monetization.
enum WatchProviderType {
  free('flatrate'),
  rent('rent'),
  buy('buy'),
  ad('ads');

  final String value;
  const WatchProviderType(this.value);
}

/// Types of TV show content.
enum TvContentType {
  documentary('1'),
  scripted('2');

  final String value;
  const TvContentType(this.value);
}
