import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_transact/data/network/custom_cache_interceptor.dart';

/// A fake adapter that records how many times it was hit and returns a
/// counter-tagged JSON body so cache hits can be distinguished from misses.
class _FakeAdapter implements HttpClientAdapter {
  int calls = 0;
  int statusCode = 200;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    calls++;
    return ResponseBody.fromString(
      jsonEncode({'call': calls}),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Dio _dio(_FakeAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
  dio.httpClientAdapter = adapter;
  dio.interceptors.add(CacheInterceptor());
  return dio;
}

void main() {
  test('caches GET requests to a categories endpoint', () async {
    final adapter = _FakeAdapter();
    final dio = _dio(adapter);

    final first = await dio.get('/categories');
    final second = await dio.get('/categories');

    expect(adapter.calls, 1, reason: 'second call should be served from cache');
    expect(first.data, {'call': 1});
    expect(second.data, {'call': 1});
  });

  test('does not cache GET requests to other endpoints', () async {
    final adapter = _FakeAdapter();
    final dio = _dio(adapter);

    await dio.get('/users');
    await dio.get('/users');

    expect(adapter.calls, 2);
  });

  test('does not cache non-GET requests to a categories endpoint', () async {
    final adapter = _FakeAdapter();
    final dio = _dio(adapter);

    await dio.post('/categories', data: {});
    await dio.post('/categories', data: {});

    expect(adapter.calls, 2);
  });

  test('forwards errors from failed responses as DioException', () async {
    final adapter = _FakeAdapter()..statusCode = 500;
    final dio = _dio(adapter);

    await expectLater(dio.get('/users'), throwsA(isA<DioException>()));
  });
}
