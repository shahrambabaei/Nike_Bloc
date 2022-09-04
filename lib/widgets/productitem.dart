import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/data/models/product.dart';
import 'package:nike/ui/product/detailscreen.dart';
import 'package:nike/configs/utils.dart';
import 'package:nike/widgets/imageloadingservice.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
    required this.borderRadius,
  }) : super(key: key);

  final ProductEntity product;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(
                        product: product,
                      )));
        },
        child: SizedBox(
          width: 176,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              children: [
                SizedBox(
                  width: 176,
                  height: 189,
                  child: ImageLoadingService(
                    imageUrl: product.imageUrl,
                    borderRadius: borderRadius,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    height: 34,
                    width: 34,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
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
              child:
                  Text(product.title, maxLines: 1, overflow: TextOverflow.fade),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.previousPrice.withPriceLable,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(decoration: TextDecoration.lineThrough),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(product.price.withPriceLable),
            )
          ]),
        ),
      ),
    );
  }
}
