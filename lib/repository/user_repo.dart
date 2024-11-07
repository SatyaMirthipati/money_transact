import 'package:money_transact/data/network/api_client.dart';
import 'package:money_transact/data/network/api_endpoints.dart';

class UserRepo {
  Future login({required body}) async {
    var response = await apiClient.post(Api.login, body);
    return response;
  }
}
