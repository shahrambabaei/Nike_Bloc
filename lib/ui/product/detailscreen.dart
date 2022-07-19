import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/configs/theme.dart';
import 'package:nike/data/models/product.dart';
import 'package:nike/ui/product/comment/comment_list.dart';
import 'package:nike/utils/engine.dart';
import 'package:nike/widgets/imageloadingservice.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.product}) : super(key: key);
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(physics: defaultScrollPhysics, slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.width * .7,
            flexibleSpace: ImageLoadingService(imageUrl: product.imageUrl),
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
                        child: Text(product.title,
                            style: Theme.of(context).textTheme.headline6)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          product.previousPrice.withPriceLable,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .apply(decoration: TextDecoration.lineThrough),
                        ),
                        Text(product.price.withPriceLable),
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
                    TextButton(onPressed: () {}, child: const Text(' ثبت نظر'))
                  ],
                ),
              ]),
            ),
          ),
          CommentList(productId: product.id)
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: FloatingActionButton.extended(
              onPressed: () {}, label: const Text('افزودن به سبد خرید')),
        ),
      ),
    );
  }
}
