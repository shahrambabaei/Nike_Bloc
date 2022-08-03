import 'package:dio/dio.dart';
import 'package:nike/configs/constans.dart';
import 'package:nike/configs/http_respose_validatore.dart';
import 'package:nike/data/models/authinfo.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, password);
  Future<AuthInfo> signUp(String username, String password);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource
    with HttpResponseValidatore
    implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteDataSource(this.httpClient);
  @override
  Future<AuthInfo> login(String username, password) async {
    final response = await httpClient.post('auth/token', data: {
      'grant_type': 'password',
      'client_id': '2',
      'client_secret': Constans.clientSecret,
      'username': username,
      'password': password
    });
    validateResponse(response);
    return AuthInfo(
        response.data["access_token"], response.data["refresh_token"]);
  }

  @override
  Future<AuthInfo> refreshToken(String token) async{
   final response= await httpClient.post("auth/token", data: {
      "grant_type": "refresh_token",
      "refresh_token": token,
      "client_id": 2,
      "client_secret": Constans.clientSecret
    });
    validateResponse(response);
     return AuthInfo(
        response.data["access_token"], response.data["refresh_token"]);
  }

  @override
  Future<AuthInfo> signUp(String username, String password) async {
    final response = await httpClient
        .post('user/register', data: {"email": username, "password": password});
    validateResponse(response);
    return login(username, password);
  }
}
