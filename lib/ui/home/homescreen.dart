import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/configs/theme.dart';
import 'package:nike/ui/home/bloc/home_bloc.dart';
import 'package:nike/utils/engine.dart';
import 'package:nike/widgets/bannerslider.dart';
import 'package:nike/widgets/homescreen.dart/horisontalproductlist.dart';
import 'package:nike/widgets/imageloadingservice.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeSuccess) {
          return ListView.builder(
            physics:defaultScrollPhysics ,
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
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(state.exceptions.messege),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                  },
                  child: Text('تلاش دوباره'))
            ]),
          );
        } else {
          throw Exception('state is not supported');
        }
      })),
    );
  }
}
