import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nike/configs/theme.dart';
import 'package:nike/data/repo/auth_repository.dart';
import 'package:nike/ui/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernameController =
      TextEditingController(text: 'test@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    const onBackground = LightThemeColors.onBackgroundColor;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Theme(
            data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context)
                    .colorScheme
                    .copyWith(onSurface: onBackground),
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(color: onBackground.withOpacity(.7)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: onBackground, width: 1)),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStateProperty.all(onBackground),
                        foregroundColor: MaterialStateProperty.all(
                            LightThemeColors.secondaryColor),
                        minimumSize: MaterialStateProperty.all(
                            const Size.fromHeight(56))))),
            child: Scaffold(
                backgroundColor: LightThemeColors.secondaryColor,
                body: BlocProvider<AuthBloc>(
                    create: (context) {
                      final bloc = AuthBloc(authRepository);
                      bloc.stream.forEach((state) {
                        if (state is AuthSuccess) {
                          Navigator.of(context).pop();
                        } else if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.exception.messege)));
                        }
                      });
                      bloc.add(AuthStarted());
                      return bloc;
                    },
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: BlocBuilder<AuthBloc, AuthState>(
                            buildWhen: (previous, current) =>
                                current is AuthLoading ||
                                current is AuthInitial ||
                                current is AuthError,
                            builder: (context, state) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/nike_logo.png',
                                  width: 100,
                                  color: onBackground,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 18, bottom: 5),
                                  child: Text(
                                    state.isLoginMode
                                        ? ' خوش آمدید'
                                        : ' ثبت نام',
                                    style: const TextStyle(
                                        fontSize: 22, color: onBackground),
                                  ),
                                ),
                                Text(
                                  state.isLoginMode
                                      ? 'لطفا وارد حساب کاربری خود شوید'
                                      : '  ایمیل و روز عبور خور را وارد کنید',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: onBackground.withOpacity(.7)),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 30, bottom: 10),
                                  child: TextField(
                                    controller: usernameController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        label: Text('ایمیل')),
                                  ),
                                ),
                                _PasswordTextField(
                                    controller: passwordController,
                                    onBackground: onBackground),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          BlocProvider.of<AuthBloc>(context)
                                              .add(AuthButtonIsClicked(
                                                  usernameController.text,
                                                  passwordController.text));
                                        },
                                        child: state is AuthLoading
                                            ? const CircularProgressIndicator()
                                            : Text(state.isLoginMode
                                                ? 'ورود  '
                                                : ' ثبت نام'))),
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(AuthModeChangeIsClicked());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.isLoginMode
                                            ? 'حساب کاربری ندارید؟'
                                            : 'حساب کاربری دارید؟',
                                        style: TextStyle(
                                            color:
                                                onBackground.withOpacity(0.7)),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        state.isLoginMode ? 'ثبت نام' : 'ورود',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                )
                                // InkWell(
                                //   onTap: () {
                                //     BlocProvider.of<AuthBloc>(context)
                                //         .add(AuthModeChangeIsClicked());
                                //   },
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Text(
                                //         state.isLoginMode
                                //             ? 'حساب کاربری ندارید؟'
                                //             : 'حساب کاربری دارید؟',
                                //         style: TextStyle(
                                //             color:
                                //                 onBackground.withOpacity(.7)),
                                //       ),
                                //       const SizedBox(
                                //         width: 5,
                                //       ),
                                //       Text(
                                //           state.isLoginMode
                                //               ? ' ثبت نام'
                                //               : '  ورود',
                                //           style: const TextStyle(
                                //               color:
                                //                   LightThemeColors.primaryColor,
                                //               decoration:
                                //                   TextDecoration.underline))
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          )),
                    )))));
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    Key? key,
    required this.onBackground,
    required this.controller,
  }) : super(key: key);

  final Color onBackground;
  final TextEditingController controller;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      controller: widget.controller,
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
