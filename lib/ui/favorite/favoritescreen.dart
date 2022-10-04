import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nike/configs/theme.dart';
import 'package:nike/configs/utils.dart';
import 'package:nike/data/models/favorite_manager.dart';
import 'package:nike/data/models/product.dart';
import 'package:nike/ui/product/detailscreen.dart';
import 'package:nike/widgets/imageloadingservice.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('لیست علاقه مندی ها'),
        ),
        body: ValueListenableBuilder<Box<ProductEntity>>(
          valueListenable: favoriteManager.listenable,
          builder: (context, box, child) {
            final products = box.values.toList();
            return ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 100),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(product: product)));
                  },
                  onLongPress: (){
                    favoriteManager.delete(product);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 110,
                          width: 110,
                          child: ImageLoadingService(
                              imageUrl: product.imageUrl,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.title,
                                    style: themeData.textTheme.subtitle1!.apply(
                                        color:
                                            LightThemeColors.primaryTextColor)),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  product.previousPrice.withPriceLable,
                                  style: themeData.textTheme.caption!.apply(
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Text(product.price.withPriceLable)
                              ]),
                        ))
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
