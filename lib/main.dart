import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nike/configs/theme.dart';
import 'package:nike/data/models/favorite_manager.dart';

import 'package:nike/data/repo/auth_repository.dart';
import 'package:nike/data/repo/banner_repository.dart';
import 'package:nike/data/repo/product_repository.dart';

import 'package:nike/ui/home/bloc/home_bloc.dart';
import 'package:nike/ui/root.dart';

void main() async {
  await FavoriteManager.init();
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
        fontFamily: 'Shabnam', color: LightThemeColors.primaryTextColor);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          snackBarTheme: SnackBarThemeData(
            contentTextStyle: defaultTextStyle.apply(color: Colors.white),
          ),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: LightThemeColors.primaryTextColor,
              elevation: 0),
          hintColor: LightThemeColors.secondaryTextColor,
          inputDecorationTheme: InputDecorationTheme(
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          LightThemeColors.primaryTextColor.withOpacity(.1)))),
          textTheme: TextTheme(
            bodyText2: defaultTextStyle,
            button: defaultTextStyle,
            subtitle1: defaultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor),
            caption: defaultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor),
            headline6: defaultTextStyle.copyWith(
                fontWeight: FontWeight.bold, fontSize: 18),
          ),
          colorScheme: const ColorScheme.light(
              primary: LightThemeColors.primaryColor,
              secondary: LightThemeColors.secondaryColor,
              onSecondary: Colors.white),
        ),
        home: Directionality(
            textDirection: TextDirection.rtl,
            child: BlocProvider(
              create: (context) {
                final homeBloc = HomeBloc(
                    bannerRepository: bannerRepository,
                    productRepository: productRepository);
                homeBloc.add(HomeStarted());
                return homeBloc;
              },
              child: const MainScreen(),
            )));
  }
}
