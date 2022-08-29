import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike/configs/theme.dart';
import 'package:nike/data/repo/auth_repository.dart';
import 'package:nike/data/repo/cart_repository.dart';
import 'package:nike/ui/auth/auth.dart';
import 'package:nike/ui/cart/bloc/cart_bloc.dart';
import 'package:nike/ui/cart/cart_item.dart';
import 'package:nike/widgets/empty_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartBloc cartBloc;
  @override
  void initState() {
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
    super.initState();
  }

  void authChangeNotifierListener() {
    cartBloc.add(CartAuthInfoChanged(AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier
        .removeListener(authChangeNotifierListener);
    cartBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LightThemeColors.surfaceVariant,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('سبدخرید'),
        ),
        body: BlocProvider<CartBloc>(create: (context) {
          final bloc = CartBloc(cartRepository);
          cartBloc = bloc;
          bloc.add(CartStarted(AuthRepository.authChangeNotifier.value));
          return bloc;
        }, child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartError) {
              return Center(
                child: Text(state.appException.messege),
              );
            } else if (state is CartSuccess) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.cartResponse.cartItems.length,
                itemBuilder: (context, index) {
                  final data = state.cartResponse.cartItems[index];
                  return Cartitem(
                    data: data,
                    onDeleteButtonClick: () {
                      cartBloc.add(CartDeleteButtonClick(data.id));
                    },
                  );
                },
              );
            } else if (state is CartAuthRequired) {
              return EmptyView(
                message: 'برای مشاهده سبدخرید ابتدا وارد حساب کاربری خود شوید',
                callToAction: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ),
                    );
                  },
                  child: const Text(' ورود به حساب کاربری'),
                ),
                image: SvgPicture.asset(
                  'assets/images/auth_required.svg',
                  width: 140,
                ),
              );
            } else if (state is CartEmpty) {
              return EmptyView(
                  message: 'تاکنون هیچ محصولی به سبدخرید خود اضافه نکرده اید',
                  callToAction: null,
                  image: SvgPicture.asset(
                    'assets/images/empty_cart.svg',
                    width: 200,
                  ));
            } else {
              throw Exception('Current cart state is not valid');
            }
          },
        )));
  }
}
