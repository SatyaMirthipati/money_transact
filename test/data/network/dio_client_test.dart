import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_transact/data/local/shared_prefs.dart';
import 'package:money_transact/data/network/custom_cache_interceptor.dart';
import 'package:money_transact/data/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('DioClient constructor', () {
    test('configures base url, timeouts and interceptors', () {
      final client = DioClient();
      expect(client.baseUrl, 'http://192.168.0.113:8888');
      expect(client.dio.options.baseUrl, 'http://192.168.0.113:8888');
      expect(client.dio.options.connectTimeout,
          const Duration(milliseconds: 100000));
      expect(
        client.dio.interceptors.whereType<CacheInterceptor>(),
        isNotEmpty,
      );
    });
  });

  group('DioClient.getOptions', () {
    test('always sets Accept and Content-Type json headers', () async {
      final client = DioClient();
      final options = await client.getOptions();
      expect(options.headers?['Accept'], 'application/json');
      expect(options.headers?['Content-Type'], 'application/json');
      expect(options.responseType, ResponseType.json);
    });

    test('uses the explicitly provided token argument', () async {
      final client = DioClient();
      final options = await client.getOptions(t: 'Bearer explicit');
      expect(options.headers?['Authorization'], 'Bearer explicit');
    });

    test('reads the token from Prefs when none is provided', () async {
      await Prefs.setToken('stored');
      final client = DioClient();
      final options = await client.getOptions();
      expect(options.headers?['Authorization'], 'Bearer stored');
    });

    test('omits Authorization when no token is available', () async {
      final client = DioClient();
      final options = await client.getOptions();
      expect(options.headers?.containsKey('Authorization'), isFalse);
    });
  });
}
