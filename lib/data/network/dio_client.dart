import 'package:dio/dio.dart';

import '../local/shared_prefs.dart';
import 'api_client.dart';
import 'custom_cache_interceptor.dart';
import 'pretty_dio_logger.dart';

class DioClient implements ApiClient {
  late Dio dio;
  String baseUrl = 'http://192.168.0.113:8888';

  DioClient() {
    dio = Dio();
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
    );

    dio.interceptors
      ..add(CacheInterceptor())
      ..add(
        PrettyDioLogger(
          maxWidth: 80,
          error: true,
          request: true,
          requestHeader: true,
          requestBody: true,
        ),
      );
  }

  Future<Options> getOptions({String? t}) async {
    Map<String, dynamic> headers = {'Accept': 'application/json'};
    var token = t ?? await Prefs.getToken();
    if (token != null) {
      headers['Authorization'] = token;
    }
    headers['Content-Type'] = 'application/json';
    print(headers);
    return Options(
      headers: headers,
      responseType: ResponseType.json,
    );
  }

  @override
  Future delete(String path, {body, query, t}) async {
    var response = await dio.delete(
      (path),
      data: body,
      queryParameters: query,
      options: await getOptions(t: t),
    );
    return response.data;
  }

  @override
  Future get(String path, {query, Options? options, t}) async {
    try {
      var response = await dio.get(
        (path),
        queryParameters: query,
        options: options ?? await getOptions(t: t),
      );
      return response.data;
    } on Exception catch (e) {
      print('Error occurred during GET request: $e');
      return e;
    }
  }

  @override
  Future patch(String path, body, {query}) async {
    var response = await dio.patch(
      (path),
      data: body,
      queryParameters: query,
      options: await getOptions(),
    );
    return response.data;
  }

  @override
  Future post(String path, body, {query, t, bool isBuildUrl = true}) async {
    var response = await dio.post(
      (path),
      data: body,
      queryParameters: query,
      options: await getOptions(t: t),
    );
    return response.data;
  }

  @override
  Future put(String path, body, {query, t}) async {
    var response = await dio.put(
      (path),
      data: body,
      queryParameters: query,
      options: await getOptions(t: t),
    );
    return response.data;
  }
}
