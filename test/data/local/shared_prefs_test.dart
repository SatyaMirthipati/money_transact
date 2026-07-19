import 'package:flutter_test/flutter_test.dart';
import 'package:money_transact/data/local/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Prefs token', () {
    test('setToken stores value prefixed with "Bearer "', () async {
      final ok = await Prefs.setToken('abc123');
      expect(ok, isTrue);
      expect(await Prefs.getToken(), 'Bearer abc123');
    });

    test('getToken returns null when no token is stored', () async {
      expect(await Prefs.getToken(), isNull);
    });
  });

  group('Prefs brightness', () {
    test('setBrightness / getBrightness round-trips a bool', () async {
      expect(await Prefs.getBrightness(), isNull);
      expect(await Prefs.setBrightness(true), isTrue);
      expect(await Prefs.getBrightness(), isTrue);
      expect(await Prefs.setBrightness(false), isTrue);
      expect(await Prefs.getBrightness(), isFalse);
    });
  });

  group('Prefs restoreId', () {
    test('getRestoreId returns "null" string when unset', () async {
      expect(await Prefs.getRestoreId(), 'null');
    });

    test('setRestoreId then getRestoreId returns the value', () async {
      await Prefs.setRestoreId('loc-42');
      expect(await Prefs.getRestoreId(), 'loc-42');
    });
  });

  group('Prefs days', () {
    test('setDays / getDays round-trips an int by key', () async {
      expect(await Prefs.getDays('interest'), isNull);
      expect(await Prefs.setDays('interest', 30), isTrue);
      expect(await Prefs.getDays('interest'), 30);
    });
  });

  group('Prefs profile getters', () {
    test('return null when nothing is stored', () async {
      expect(await Prefs.getName(), isNull);
      expect(await Prefs.getUserId(), isNull);
      expect(await Prefs.getEmail(), isNull);
      expect(await Prefs.getMobile(), isNull);
      expect(await Prefs.getAvatar(), isNull);
    });

    test('read values seeded into SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({
        'fullName': 'Jane Doe',
        'userId': 7,
        'email': 'jane@example.com',
        'phone': '555-1234',
        'avatar': 'a.png',
      });
      expect(await Prefs.getName(), 'Jane Doe');
      expect(await Prefs.getUserId(), 7);
      expect(await Prefs.getEmail(), 'jane@example.com');
      expect(await Prefs.getMobile(), '555-1234');
      expect(await Prefs.getAvatar(), 'a.png');
    });
  });

  group('Prefs search history', () {
    test('getSearchList returns empty list when unset', () async {
      expect(await Prefs.getSearchList(), <String>[]);
    });

    test('setSearch appends a new query', () async {
      expect(await Prefs.setSearch('phones'), isTrue);
      expect(await Prefs.getSearchList(), ['phones']);
    });

    test('setSearch ignores duplicate queries', () async {
      await Prefs.setSearch('phones');
      expect(await Prefs.setSearch('phones'), isFalse);
      expect(await Prefs.getSearchList(), ['phones']);
    });

    test('setSearch keeps at most 3 entries (FIFO)', () async {
      await Prefs.setSearch('a');
      await Prefs.setSearch('b');
      await Prefs.setSearch('c');
      await Prefs.setSearch('d');
      expect(await Prefs.getSearchList(), ['b', 'c', 'd']);
    });
  });

  group('Prefs clearPrefs', () {
    test('removes all stored values', () async {
      await Prefs.setToken('abc');
      await Prefs.setBrightness(true);
      expect(await Prefs.clearPrefs(), isTrue);
      expect(await Prefs.getToken(), isNull);
      expect(await Prefs.getBrightness(), isNull);
    });
  });
}
