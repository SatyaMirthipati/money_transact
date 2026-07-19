import 'package:flutter_test/flutter_test.dart';
import 'package:money_transact/data/network/api_endpoints.dart';

void main() {
  group('Api endpoints', () {
    test('login path is "/auth"', () {
      expect(Api.login, '/auth');
    });
  });
}
