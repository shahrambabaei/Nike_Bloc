import 'package:flutter/material.dart';

import 'package:nike/configs/theme.dart';
import 'package:nike/data/repo/auth_repository.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    const onBackground = LightThemeColors.onBackgroundColor;
    return Theme(
        data: Theme.of(context).copyWith(
            colorScheme:
                Theme.of(context).colorScheme.copyWith(onSurface: onBackground),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: onBackground.withOpacity(.7)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: onBackground, width: 1)),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor: MaterialStateProperty.all(onBackground),
                    foregroundColor: MaterialStateProperty.all(
                        LightThemeColors.secondaryColor),
                    minimumSize:
                        MaterialStateProperty.all(const Size.fromHeight(56))))),
        child: Scaffold(
          backgroundColor: LightThemeColors.secondaryColor,
          body: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/nike_logo.png',
                  width: 100,
                  color: onBackground,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 18, bottom: 5),
                  child: Text(
                    isLogin ? 'ثبت نام' : 'خوش آمدید',
                    style: const TextStyle(fontSize: 22, color: onBackground),
                  ),
                ),
                Text(
                  isLogin
                      ? 'لطفا وارد حساب کاربری خود شوید'
                      : '  ایمیل و روز عبور خور را وارد کنید',
                  style: TextStyle(
                      fontSize: 16, color: onBackground.withOpacity(.7)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 10),
                  child: const TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(label: Text('ایمیل')),
                  ),
                ),
                const _PasswordTextField(onBackground: onBackground),
                Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: ElevatedButton(
                        onPressed: () async{
                        //  await authRepository.login('test@gmail.com', '123456');
                          authRepository.refreshToken();
                        },
                        child: Text(isLogin ? 'ثبت نام' : 'ورود'))),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLogin ? 'حساب کاربری دارید؟' : 'حساب کاربری ندارید؟',
                        style: TextStyle(color: onBackground.withOpacity(.7)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(isLogin ? 'ورود' : 'ثبت نام',
                          style: const TextStyle(
                              color: LightThemeColors.primaryColor,
                              decoration: TextDecoration.underline))
                    ],
                  ),
                )
              ],
            ),
          )),
        ));
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    Key? key,
    required this.onBackground,
  }) : super(key: key);

  final Color onBackground;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          label: const Text('رمز عبور'),
          suffixIcon: IconButton(
              splashRadius: 20,
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: widget.onBackground.withOpacity(.7),
              ))),
    );
  }
}
