/// [WatchProvider] represents a single streaming or rental provider.
class WatchProvider {
  final String? logoPath;
  final int providerId;
  final String providerName;
  final int displayPriority;

  WatchProvider({
    this.logoPath,
    required this.providerId,
    required this.providerName,
    required this.displayPriority,
  });

  factory WatchProvider.fromJson(Map<String, dynamic> json) {
    return WatchProvider(
      logoPath: json['logo_path'] as String?,
      providerId: json['provider_id'] as int,
      providerName: json['provider_name'] as String? ?? '',
      displayPriority: json['display_priority'] as int? ?? 0,
    );
  }
}

/// [CountryWatchProviders] contains the streaming, rent, and buy providers for a country.
class CountryWatchProviders {
  final String link;
  final List<WatchProvider> buy;
  final List<WatchProvider> flatrate;
  final List<WatchProvider> rent;

  CountryWatchProviders({
    required this.link,
    required this.buy,
    required this.flatrate,
    required this.rent,
  });

  factory CountryWatchProviders.fromJson(Map<String, dynamic> json) {
    return CountryWatchProviders(
      link: json['link'] as String? ?? '',
      buy:
          (json['buy'] as List?)
              ?.map((i) => WatchProvider.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      flatrate:
          (json['flatrate'] as List?)
              ?.map((i) => WatchProvider.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      rent:
          (json['rent'] as List?)
              ?.map((i) => WatchProvider.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

/// [TmdbWatchProvidersResponse] is a unified response for movie or TV watch providers.
class TmdbWatchProvidersResponse {
  final int id;
  final Map<String, CountryWatchProviders> results;

  TmdbWatchProvidersResponse({required this.id, required this.results});

  factory TmdbWatchProvidersResponse.fromJson(Map<String, dynamic> json) {
    final rawResults = json['results'] as Map<String, dynamic>? ?? {};
    final mappedResults = <String, CountryWatchProviders>{};

    rawResults.forEach((country, data) {
      mappedResults[country] = CountryWatchProviders.fromJson(
        data as Map<String, dynamic>,
      );
    });

    return TmdbWatchProvidersResponse(
      id: json['id'] as int? ?? 0,
      results: mappedResults,
    );
  }
}
