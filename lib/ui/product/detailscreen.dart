import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/configs/theme.dart';
import 'package:nike/data/models/product.dart';
import 'package:nike/data/repo/cart_repository.dart';
import 'package:nike/ui/product/bloc/product_bloc.dart';
import 'package:nike/ui/product/comment/comment_list.dart';
import 'package:nike/configs/utils.dart';
import 'package:nike/widgets/imageloadingservice.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.product}) : super(key: key);
  final ProductEntity product;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  StreamSubscription<ProductState>? stateSubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  @override
  void dispose() {
    stateSubscription?.cancel();
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider<ProductBloc>(
          create: (context) {
            final bloc = ProductBloc(cartRepository);
            stateSubscription = bloc.stream.listen((state) {
              if (state is ProductAddToCartSuccess) {
                _scaffoldKey.currentState!.showSnackBar(const SnackBar(
                    content: Text(
                        'کالای مورد نطر با موفقیت به سبد خرید شما اضافه شد')));
              } else if (state is ProductAddToCartError) {
                _scaffoldKey.currentState!.showSnackBar(
                    SnackBar(content: Text(state.exception.messege)));
              }
            });
            return bloc;
          },
          child: ScaffoldMessenger(
            key: _scaffoldKey,
            child: Scaffold(
              body: CustomScrollView(physics: defaultScrollPhysics, slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * .7,
                  flexibleSpace:
                      ImageLoadingService(imageUrl: widget.product.imageUrl),
                  foregroundColor: LightThemeColors.primaryTextColor,
                  actions: const [Icon(CupertinoIcons.heart)],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(widget.product.title,
                                  style:
                                      Theme.of(context).textTheme.headline6)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.product.previousPrice.withPriceLable,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .apply(
                                        decoration: TextDecoration.lineThrough),
                              ),
                              Text(widget.product.price.withPriceLable),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا. هیچ فشار مخربی رو نمیذارد به پا و زانوان شما انتقال داده شود',
                        style: TextStyle(height: 1.4),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'نظرات کاربران',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text(' ثبت نظر'))
                        ],
                      ),
                    ]),
                  ),
                ),
                CommentList(productId: widget.product.id)
              ]),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) => FloatingActionButton.extended(
                        onPressed: () {
                          BlocProvider.of<ProductBloc>(context).add(
                              CartAddButtonClick(productId: widget.product.id));
                        },
                        label: state is ProductAddToCartLoading
                            ? const CupertinoActivityIndicator(
                                color: LightThemeColors.onSecondaryColor,
                              )
                            : const Text('افزودن به سبد خرید')),
                  )),
            ),
          ),
        ));
  }
}
