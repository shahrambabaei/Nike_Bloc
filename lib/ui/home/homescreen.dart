import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/ui/home/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeSuccess) {
          return ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Image.asset(
                      'assets/images/nike_logo.png',
                      height: 32,
                    );
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
