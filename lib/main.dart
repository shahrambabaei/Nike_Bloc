import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/configs/theme.dart';
import 'package:nike/data/repo/banner_repository.dart';
import 'package:nike/data/repo/product_repository.dart';
import 'package:nike/ui/home/bloc/home_bloc.dart';
import 'package:nike/ui/home/homescreen.dart';

void main() {
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
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme: TextTheme(
                bodyText2: defaultTextStyle,
                button: defaultTextStyle,
                subtitle1: defaultTextStyle.apply(
                    color: LightThemeColors.secondaryTextColor),
                caption: defaultTextStyle.apply(
                    color: LightThemeColors.secondaryTextColor),
                headline6: defaultTextStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 18)),
            colorScheme: const ColorScheme.light(
                primary: LightThemeColors.primaryColor,
                secondary: LightThemeColors.secondaryColor,
                onSecondary: Colors.white)),
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
              child: const HomeScreen(),
            )));
  }
}
