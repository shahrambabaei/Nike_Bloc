import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/configs/theme.dart';
import 'package:nike/data/models/authinfo.dart';
import 'package:nike/data/repo/auth_repository.dart';
import 'package:nike/data/repo/cart_repository.dart';
import 'package:nike/ui/auth/auth.dart';
import 'package:nike/ui/cart/bloc/cart_bloc.dart';
import 'package:nike/utils/engine.dart';
import 'package:nike/widgets/imageloadingservice.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('سبدخرید'),
        ),
        body: BlocProvider<CartBloc>(create: (context) {
          final bloc = CartBloc(cartRepository);
          bloc.add(CartStarted());
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
                itemCount: state.cartResponse.cartItems.length,
                itemBuilder: (context, index) {
                  final data = state.cartResponse.cartItems[index];
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: LightThemeColors.surfacedColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.05),
                              blurRadius: 10)
                        ]),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          SizedBox(
                              width: 100,
                              height: 100,
                              child: ImageLoadingService(
                                  imageUrl: data.product.imageUrl)),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(data.product.title,
                                style: const TextStyle(fontSize: 16)),
                          ))
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('تعداد'),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            CupertinoIcons.plus_rectangle),
                                      ),
                                      Text(
                                        data.count.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            CupertinoIcons.minus_rectangle),
                                      ),
                                    ],
                                  )
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data.product.previousPrice.withPriceLable,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    data.product.price.withPriceLable,
                                  ),
                                ])
                          ],
                        ),
                      ),
                      const Divider(height: 2),
                      TextButton(
                        onPressed: () {},
                        child: const Text('حذف از سبد خرید'),
                      )
                    ]),
                  );
                },
              );
            } else {
              throw Exception('Current cart state is not valid');
            }
          },
        ))

        //  ValueListenableBuilder<AuthInfo?>(
        //   valueListenable: AuthRepository.authChangeNotifier,
        //   builder: (context, authState, child) {
        //     final isAuthenticated =
        //         authState != null && authState.accesstoken.isNotEmpty;
        //     return Center(
        //         child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(isAuthenticated
        //             ? 'خوش آمدید'
        //             : 'لطفا وارد حساب کاربری خود شوید'),
        //         isAuthenticated
        //             ? ElevatedButton(
        //                 onPressed: () {
        //                   authRepository.signOut();
        //                 },
        //                 child: const Text('خروج از حساب'))
        //             : ElevatedButton(
        //                 onPressed: () {
        //                   Navigator.of(context, rootNavigator: true).push(
        //                       MaterialPageRoute(
        //                           builder: (context) => const AuthScreen()));
        //                 },
        //                 child: const Text('ورود')),
        //         ElevatedButton(
        //             onPressed: () async {
        //               await authRepository.refreshToken();
        //             },
        //             child: const Text('Refresh Token')),
        //       ],
        //     ));
        //   },
        // ),
        );
  }
}
