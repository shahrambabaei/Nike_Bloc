import 'package:flutter/material.dart';
import 'package:nike/data/models/authinfo.dart';
import 'package:nike/data/repo/auth_repository.dart';
import 'package:nike/ui/auth/auth.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('سبدخرید'),
        ),
        body: ValueListenableBuilder<AuthInfo?>(
          valueListenable: AuthRepository.authChangeNotifier,
          builder: (context, authState, child) {
            final isAuthenticated =
                authState != null && authState.accesstoken.isNotEmpty;
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isAuthenticated
                    ? 'خوش آمدید'
                    : 'لطفا وارد حساب کاربری خود شوید'),
                isAuthenticated
                    ? ElevatedButton(
                        onPressed: () {
                          authRepository.signOut();
                        },
                        child: const Text('خروج از حساب'))
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => const AuthScreen()));
                        },
                        child: const Text('ورود')),
                ElevatedButton(
                    onPressed: () async {
                      await authRepository.refreshToken();
                    },
                    child: const Text('Refresh Token')),
              ],
            ));
          },
        ));
  }
}
