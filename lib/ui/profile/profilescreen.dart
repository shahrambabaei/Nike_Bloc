import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/data/models/authinfo.dart';
import 'package:nike/data/repo/auth_repository.dart';
import 'package:nike/data/repo/cart_repository.dart';
import 'package:nike/ui/auth/auth.dart';

class ProfileSceen extends StatelessWidget {
  const ProfileSceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<AuthInfo?>(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, authInfo, child) {
          final isLogin = authInfo != null && authInfo.accesstoken.isNotEmpty;
          return Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 65,
                width: 65,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(top: 32, bottom: 8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).dividerColor, width: 1)),
                child: Image.asset(
                  'assets/images/nike_logo.png',
                ),
              ),
              Text(isLogin ? authInfo.email : 'کاربر مهمان'),
              const SizedBox(
                height: 32,
              ),
              const Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 56,
                  child: Row(
                    children: const <Widget>[
                      Icon(CupertinoIcons.heart),
                      SizedBox(
                        width: 15,
                      ),
                      Text('لیست علاقه مندی ها')
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 56,
                  child: Row(
                    children: const <Widget>[
                      Icon(CupertinoIcons.cart),
                      SizedBox(
                        width: 15,
                      ),
                      Text('   سوابق سفارش')
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  if (isLogin) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: AlertDialog(
                            title: const Text('خروج از حساب کاربری'),
                            content: const Text(
                                'آیا میخواهد از حساب کاربری خود خارج شوید؟'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('خیر')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    CartRepository
                                            .cartItemCountNotifier.value ==
                                        0;
                                    authRepository.signOut();
                                  },
                                  child: const Text('بله')),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 56,
                  child: Row(
                    children: <Widget>[
                      Icon(isLogin
                          ? CupertinoIcons.arrow_right_square
                          : CupertinoIcons.arrow_left_square),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(isLogin
                          ? 'خروج از حساب کاربری '
                          : 'ورود به حساب کاربری')
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 1,
              ),
            ],
          ));
        },
      ),
    );
  }
}
