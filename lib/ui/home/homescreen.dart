import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/ui/home/bloc/home_bloc.dart';
import 'package:nike/utils/engine.dart';
import 'package:nike/widgets/apperrorwidget.dart';
import 'package:nike/widgets/bannerslider.dart';
import 'package:nike/widgets/homescreen.dart/horisontalproductlist.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeSuccess) {
          return ListView.builder(
              physics: defaultScrollPhysics,
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Container(
                      height: 56,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/nike_logo.png',
                        height: 24,
                      ),
                    );
                  case 2:
                    return BannerSlider(banners: state.banners);
                  case 3:
                    return HorisontalProductList(
                        title: 'جدیدترین',
                        products: state.latestProducts,
                        onClick: () {});
                  case 4:
                    return HorisontalProductList(
                        title: 'پربازدیدترین',
                        products: state.popularProducts,
                        onClick: () {});

                  default:
                    return Container();
                }
              });
        } else if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeError) {
          return AppErrorwidget(
              exception: state.exception,
              onClick: () {
                BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
              });
        } else {
          throw Exception('state is not supported');
        }
      })),
    );
  }
}
