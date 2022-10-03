import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/data/models/favorite_manager.dart';
import 'package:nike/data/models/product.dart';
import 'package:nike/ui/product/detailscreen.dart';
import 'package:nike/configs/utils.dart';
import 'package:nike/widgets/imageloadingservice.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.product,
    required this.borderRadius,
    this.itemWidth = 176,
    this.itemHeight = 189,
  }) : super(key: key);

  final ProductEntity product;
  final BorderRadius borderRadius;
  final double itemWidth;
  final double itemHeight;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        borderRadius: widget.borderRadius,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(
                        product: widget.product,
                      )));
        },
        child: SizedBox(
          width: widget.itemWidth,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: .93,
                  child: ImageLoadingService(
                    imageUrl: widget.product.imageUrl,
                    borderRadius: widget.borderRadius,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: InkWell(
                    onTap: () {
                      if (!favoriteManager.isFavorite(widget.product)) {
                        favoriteManager.addFavorite(widget.product);
                      } else {
                        favoriteManager.delete(widget.product);
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 34,
                      width: 34,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        favoriteManager.isFavorite(widget.product)
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        size: 22,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(widget.product.title,
                  maxLines: 1, overflow: TextOverflow.fade),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.product.previousPrice.withPriceLable,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(decoration: TextDecoration.lineThrough),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(widget.product.price.withPriceLable),
            )
          ]),
        ),
      ),
    );
  }
}
