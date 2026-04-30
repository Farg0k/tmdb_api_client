import 'package:tmdb_api_client/tmdb_api_client.dart'; // Import our TMDB API client package.
import 'dart:io'; // Required for console input/output (stdin.readLineSync).

/// The main entry point of the example application.
void main() async {
  // --- IMPORTANT: Replace with your actual TMDB API Key (v3) ---
  const String apiKey = 'YOUR_TMDB_API_KEY';

  // --- API Key Validation ---
  if (apiKey == 'YOUR_TMDB_API_KEY') {
    print('ПОМИЛКА: Будь ласка, замініть "YOUR_TMDB_API_KEY" в example/main.dart на ваш реальний ключ TMDB API (v3).');
    return; // Exit if API key is not set.
  }

  // Initialize the TMDB API client with the API key and preferred language.
  final config = TmdbApiClientConfig(apiKey: apiKey, language: 'en-US'); // Using English for consistency in example.
  final tmdbClient = TmdbApiClient(config: config);

  try {
    print('\n--- Демонстрація автентифікації користувача TMDB ---');

    // 1. Отримання Request Token
    print('Крок 1: Отримання нового Request Token...');
    final requestTokenResponse = await tmdbClient.authentication.createRequestToken();
    print('  ✅ Отримано Request Token: ${requestTokenResponse.requestToken}');
    print('  ⏳ Токен спливає: ${requestTokenResponse.expiresAt}');

    // 2. Схвалення токена користувачем
    final approveUrl = 'https://www.themoviedb.org/authenticate/${requestTokenResponse.requestToken}';
    print('\nКрок 2: Необхідне схвалення користувачем');
    print('  Будь ласка, відкрийте наступне посилання у вашому веб-браузері та схваліть токен:');
    print('  🔗 $approveUrl');
    print('\n  Натисніть Enter у цій консолі ПІСЛЯ того, як ви схвалите токен у своєму браузері...');
    stdin.readLineSync(); // Pauses execution until the user presses Enter.

    // 3. Створення Session ID з схваленого Request Token
    print('\nКрок 3: Створення Session ID зі схваленого Request Token...');
    Session? sessionResponse; // Make it nullable as it might not be created.
    try {
      sessionResponse = await tmdbClient.authentication.createSession(requestTokenResponse.requestToken);
      if (sessionResponse.success) {
        print('  ✅ Session ID успішно створено: ${sessionResponse.sessionId}');
        // Verify that the client's internal config has been updated.
        print('     Конфігурацію клієнта оновлено з sessionId: ${tmdbClient.config.sessionId}');
      } else {
        print('  ❌ Помилка при створенні Session ID. Будь ласка, переконайтеся, що токен було схвалено.');
      }
    } on TmdbApiException catch (e) {
      print('  ❌ Помилка API при створенні Session ID: ${e.message}');
    }

    // --- NEW: Demonstrate fetching account details AFTER a session is created ---
    if (sessionResponse != null && sessionResponse.success) {
      print('\n--- Демонстрація отримання деталей облікового запису ---');
      print('Отримання деталей облікового запису для активної сесії...');
      try {
        final accountDetails = await tmdbClient.account.getDetails();
        print('  ✅ Деталі облікового запису отримано:');
        print('     ID: ${accountDetails.id}');
        print('     Ім\'я: ${accountDetails.name}');
        print('     Ім\'я користувача: ${accountDetails.username}');
        if (accountDetails.fullGravatarUrl != null) {
          print('     URL аватара (Gravatar): ${accountDetails.fullGravatarUrl}');
        }
      } on TmdbApiException catch (e) {
        print('  ❌ Помилка API при отриманні деталей облікового запису: ${e.message} (Статус: ${e.statusCode})');
        print('     Це очікувано, якщо сесію не було створено успішно або вона недійсна.');
      }
    } else {
      print('\n--- Деталі облікового запису пропущено, оскільки Session ID не було створено ---');
    }

    // --- Demonstration of Guest Session (Independent Flow) ---
    print('\n--- Демонстрація створення Guest Session ---');
    print('Створення Guest Session...');
    final guestSessionResponse = await tmdbClient.authentication.createGuestSession();
    if (guestSessionResponse.success) {
      print('  ✅ Guest Session ID успішно створено: ${guestSessionResponse.guestSessionId}');
      print('     Guest Session спливає: ${guestSessionResponse.expiresAt}');
    } else {
      print('  ❌ Помилка при створенні Guest Session.');
    }

    // --- Step 4: Delete the Session ID (if one was successfully created) ---
    if (sessionResponse != null && sessionResponse.success) {
      print('\n--- Демонстрація видалення Session ID ---');
      print('Видалення Session ID: ${sessionResponse.sessionId}...');
      final deleteSuccess = await tmdbClient.authentication.deleteSession(sessionResponse.sessionId);
      if (deleteSuccess) {
        print('  ✅ Сесію успішно видалено.');
        // Verify that the client's internal config has been cleared.
        print('     Session ID в клієнті після видалення: ${tmdbClient.config.sessionId}');
      } else {
        print('  ❌ Помилка при видаленні сесії.');
      }
    }

  } on TmdbApiException catch (e) {
    // Catch specific TMDB API errors.
    print('🛑 TMDB API Помилка: ${e.message} (Статус: ${e.statusCode}, Код: ${e.errorCode ?? 'N/A'})');
  } on TmdbNetworkException catch (e) {
    // Catch network connectivity errors.
    print('🌐 Мережева Помилка: ${e.message}');
  } catch (e) {
    // Catch any other unexpected errors.
    print('❓ Виникла неочікувана помилка: $e');
  } finally {
    // Always close the HTTP client to release resources.
    tmdbClient.close();
    print('\nTMDB API клієнт закрито.');
  }
}