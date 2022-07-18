import 'package:flutter/material.dart';
import 'package:nike/data/models/product.dart';
import 'package:nike/utils/engine.dart';
import 'package:nike/widgets/productitem.dart';

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
              return ProductItem(
                product: product,
                borderRadius: BorderRadius.circular(12),
              );
            }),
      )
    ]);
  }
}
