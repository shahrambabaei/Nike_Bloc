import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nike/data/models/product.dart';
import 'package:nike/utils/engine.dart';
import 'package:nike/widgets/imageloadingservice.dart';

class HorisontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onClick;
  final List<ProductEntity> products;
  const HorisontalProductList(
      {Key? key,
      required this.title,
      required this.products,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextButton(onPressed: () {}, child: const Text('مشاهده همه'))
          ],
        ),
      ),
      SizedBox(
        height: 290,
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            physics: defaultScrollPhysics,
            itemCount: products.length,
            itemBuilder: (conttext, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 176,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 176,
                              height: 189,
                              child: ImageLoadingService(
                                  imageUrl: product.imageUrl,
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                height: 34,
                                width: 34,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: const Icon(
                                  CupertinoIcons.heart,
                                  size: 22,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(product.title,
                              maxLines: 1, overflow: TextOverflow.fade),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            product.previousPrice.withPriceLable,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(product.price.withPriceLable),
                        )
                      ]),
                ),
              );
            }),
      )
    ]);
  }
}
