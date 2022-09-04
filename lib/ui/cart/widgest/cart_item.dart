import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/configs/theme.dart';
import 'package:nike/data/models/cart_item.dart';
import 'package:nike/configs/utils.dart';
import 'package:nike/widgets/imageloadingservice.dart';

class Cartitem extends StatelessWidget {
  const Cartitem({
    Key? key,
    required this.data,
    required this.onDeleteButtonClick,
  }) : super(key: key);

  final CartItemEntity data;
  final GestureTapCallback onDeleteButtonClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: LightThemeColors.surfacedColor,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)
          ]),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            SizedBox(
                width: 100,
                height: 100,
                child: ImageLoadingService(imageUrl: data.product.imageUrl)),
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
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('تعداد'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.plus_rectangle),
                    ),
                    Text(
                      data.count.toString(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.minus_rectangle),
                    ),
                  ],
                )
              ]),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
        data.deleteButtonLoading
            ? const SizedBox(
                height: 48,
                child: Center(child: CupertinoActivityIndicator()),
              )
            : TextButton(
                onPressed: onDeleteButtonClick,
                child: const Text('حذف از سبد خرید'),
              )
      ]),
    );
  }
}
