import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nike/data/models/product.dart';

final favoriteManager = FavoriteManager();

class FavoriteManager {
  static const _boxName = 'favorites';
  final box = Hive.box<ProductEntity>(_boxName);
  ValueListenable<Box<ProductEntity>> get listenable =>
      Hive.box<ProductEntity>(_boxName).listenable();
  static init() async {
    await Hive.initFlutter(_boxName);
    Hive.registerAdapter(ProductEntityAdapter());
    await Hive.openBox<ProductEntity>(_boxName);
  }

  void addFavorite(ProductEntity product) {
    box.put(product.id, product);
  }

  void delete(ProductEntity product) {
    box.delete(product.id);
  }

  List<ProductEntity> get favorites => box.values.toList();
  bool isFavorite(ProductEntity product) {
    return box.containsKey(product.id);
  }
}
