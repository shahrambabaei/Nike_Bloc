import 'package:hive_flutter/hive_flutter.dart';
part 'product.g.dart';
class ProductSort {
  static const int latest = 0;
  static const int popular = 1;
  static const int priceHighToLow = 2;
  static const int priceLowToHigh = 3;
  static const List<String> names = [
    'جدیدترین',
    'پربازدیدترین',
    'قیمت نزولی',
    'قیمت صعودی',
  ];
}
@HiveType(typeId: 0)
class ProductEntity extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final int price;
  @HiveField(4)
  final int discount;
  @HiveField(5)
  final int previousPrice;

  ProductEntity(this.title, this.id, this.imageUrl, this.price, this.discount,
      this.previousPrice);
  ProductEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['image'],
        price = json['previous_price'] == null
            ? json['price'] - json['discount']
            : json['price'],
        discount = json['discount'],
        previousPrice = json['previous_price'] ?? json['price'];
}
