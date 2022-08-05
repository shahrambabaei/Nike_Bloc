import 'package:flutter/material.dart';
import 'package:nike/configs/http_client.dart';
import 'package:nike/data/models/authinfo.dart';
import 'package:nike/data/source/auth_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
  Future<void> refreshToken();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChanggeNotofier =
      ValueNotifier(null);
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);

    _persistAuthTokens(authInfo);
  }

  @override
  Future<void> signUp(String username, String password) async {
    try {
      final AuthInfo authInfo = await dataSource.signUp(username, password);
      _persistAuthTokens(authInfo);
      debugPrint('access Token is: ' + authInfo.accesstoken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> refreshToken() async {
    final AuthInfo authInfo = await dataSource.refreshToken(
        "def50200e9a58ba70cb69b929961e9e7bec30574624485f15ba3621c6527885f70a4bde1eff1035ec75822c8b860712a40792d098c2517badb03d8d4a01e2a50055e46a47be492cfc037e3cb519318a907723ba00737a20d299de8e520a570319576ef013639be753ea58f10331c1b8cad44869ccaba8dff24fc4ee9fabb8a2cc00fcfcf310cedc5d0ea0dded639d1901d10dd9288eee7150589e85005877ca0da160292b24d2f65e5ff256d2b67d0ce5c759b25fb87ae7bbdb23ffca2ad4bd5a47cfdb05421f891d2f64598cf0fdb0e7ffc34a7ba920d49aef37210e13d927319686c6c506b009e195350d150472fae27237f605f749b38c33c6aad846e7431877b4f2badea0c28475926a9e148f66291badf9284f7155e997b4c08a048305428e56f0ed9967afa96ff8936f558d644900fe2e57f827725fa721f2592cad0b1859915aad268f76a52c39f45c00425a85865516c6d96d664408835ed11146c02b371");
    _persistAuthTokens(authInfo);
  }

  Future<void> _persistAuthTokens(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('access_Token', authInfo.accesstoken);
    sharedPreferences.setString('refresh_Token', authInfo.refreshtoken);
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString('access_Token') ?? '';
    final String refreshToken =
        sharedPreferences.getString('refresh_Token') ?? '';
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChanggeNotofier.value = AuthInfo(accessToken, refreshToken);
    }
  }
}
