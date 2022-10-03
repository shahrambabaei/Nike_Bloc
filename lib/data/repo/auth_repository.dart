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
  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifier =
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
    final AuthInfo authInfo = await dataSource.signUp(username, password);
    _persistAuthTokens(authInfo);
    debugPrint('access Token is: ${authInfo.accesstoken}');
  }

  @override
  Future<void> refreshToken() async {
    if (authChangeNotifier.value != null) {
      final AuthInfo authInfo =
          await dataSource.refreshToken(authChangeNotifier.value!.refreshtoken);
      debugPrint('refreshToken Is: ${authInfo.refreshtoken}');
      _persistAuthTokens(authInfo);
    }
  }

  Future<void> _persistAuthTokens(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('access_Token', authInfo.accesstoken);
    sharedPreferences.setString('refresh_Token', authInfo.refreshtoken);
    sharedPreferences.setString('email', authInfo.email);
    loadAuthInfo();
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString('access_Token') ?? '';
    final String refreshToken =
        sharedPreferences.getString('refresh_Token') ?? '';
    final String email = sharedPreferences.getString('email') ?? '';
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthInfo(accessToken, refreshToken, email);
    }
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }
}
