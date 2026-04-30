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
}
