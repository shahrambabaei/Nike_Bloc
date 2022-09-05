import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike/configs/theme.dart';
import 'package:nike/data/models/cart_response.dart';
import 'package:nike/data/repo/auth_repository.dart';
import 'package:nike/data/repo/cart_repository.dart';
import 'package:nike/ui/auth/auth.dart';
import 'package:nike/ui/cart/bloc/cart_bloc.dart';
import 'package:nike/ui/cart/widgest/cart_info.dart';
import 'package:nike/ui/cart/widgest/cart_item.dart';
import 'package:nike/widgets/empty_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartBloc cartBloc;
  final RefreshController _refreshController = RefreshController();
  late StreamSubscription? _streamSubscription;
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
    _streamSubscription?.cancel();
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
          _streamSubscription = bloc.stream.listen((state) {
            if (_refreshController.isRefresh) {
              if (state is CartSuccess) {
                _refreshController.refreshCompleted();
              } else if (state is CartError) {
                _refreshController.refreshFailed();
              }
            }
          });
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
              return SmartRefresher(
                controller: _refreshController,
                header: const ClassicHeader(
                  completeText: 'باموفقیت انجام شد',
                  refreshingText: 'در حال به روزرسانی',
                  idleText: 'برای به روزرسانی به سمت پایین بکشید',
                  releaseText: 'رها کنید',
                  failedText: 'خطای نامشخص',
                  completeIcon: Icon(
                    CupertinoIcons.checkmark_circle,
                    color: Colors.grey,
                    size: 20,
                  ),
                  spacing: 3,
                ),
                onRefresh: () {
                  cartBloc.add(CartStarted(
                      AuthRepository.authChangeNotifier.value,
                      isRefreshing: true));
                },
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.cartResponse.cartItems.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.cartResponse.cartItems.length) {
                      final data = state.cartResponse.cartItems[index];
                      return CartItem(
                        data: data,
                        onDeleteButtonClick: () {
                          cartBloc.add(CartDeleteButtonClick(data.id));
                        },
                        onDecreaseButtonClick: (() {
                          if (data.count > 1) {
                            cartBloc.add(CartDecreaseCountButtonCicked(data.id));
                          }
                        }),
                        onIncreaseButtonClick: () {
                          cartBloc.add(CartIncreaseCountButtonClicked(data.id));
                        },
                      );
                    } else {
                      return CartInfo(
                          payablePrice: state.cartResponse.payablePrice,
                          totalPrice: state.cartResponse.totalPrice,
                          shippingPrice: state.cartResponse.shippingPrice);
                    }
                  },
                ),
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
