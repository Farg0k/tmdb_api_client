import 'package:tmdb_api_client/tmdb_api_client.dart';
import 'package:test/test.dart';

void main() {
  group('TmdbApiClient', () {
    late TmdbApiClient client;
    final config = TmdbApiClientConfig(apiKey: 'test_api_key');

    setUp(() {
      client = TmdbApiClient(config: config);
    });

    test('can be initialized with config', () {
      expect(client.config.apiKey, equals('test_api_key'));
    });

    test('has authentication service initialized', () {
      expect(client.authentication, isNotNull);
    });

    test('has account service initialized', () {
      expect(client.account, isNotNull);
    });

    test('updateConfig updates the configuration', () {
      final newConfig = config.copyWith(language: 'uk-UA');
      client.updateConfig(newConfig);
      expect(client.config.language, equals('uk-UA'));
    });
  });

  group('TmdbExternalIds', () {
    test('fromJson handles missing id field', () {
      final json = {'imdb_id': 'tt1234567', 'facebook_id': 'fb123'};

      final externalIds = TmdbExternalIds.fromJson(json);

      expect(externalIds.id, equals(0));
      expect(externalIds.imdbId, equals('tt1234567'));
    });

    test('fromJson handles null id field', () {
      final json = {'id': null, 'imdb_id': 'tt1234567'};

      final externalIds = TmdbExternalIds.fromJson(json);

      expect(externalIds.id, equals(0));
      expect(externalIds.imdbId, equals('tt1234567'));
    });
  });
}
