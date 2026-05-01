/// [NetworkAlternativeName] represents an alternative name for a TV network.
class NetworkAlternativeName {
  final String name;
  final String type;

  NetworkAlternativeName({
    required this.name,
    required this.type,
  });

  factory NetworkAlternativeName.fromJson(Map<String, dynamic> json) {
    return NetworkAlternativeName(
      name: json['name'] as String,
      type: json['type'] as String,
    );
  }
}

class NetworkAlternativeNamesResponse {
  final int id;
  final List<NetworkAlternativeName> results;

  NetworkAlternativeNamesResponse({
    required this.id,
    required this.results,
  });

  factory NetworkAlternativeNamesResponse.fromJson(Map<String, dynamic> json) {
    return NetworkAlternativeNamesResponse(
      id: json['id'] as int,
      results: (json['results'] as List)
          .map((i) => NetworkAlternativeName.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
