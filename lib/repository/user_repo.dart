import 'package:dio/dio.dart';
import 'package:money_transact/data/network/api_client.dart';
import 'package:money_transact/data/network/api_endpoints.dart';

class UserRepo {
  Future<dynamic> login({required Map<String, dynamic> body}) async {
    try {
      final response = await apiClient.post(Api.login, body);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message ?? 'Login failed');
    }
  }
}
