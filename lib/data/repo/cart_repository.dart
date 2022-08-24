import 'package:nike/configs/http_client.dart';
import 'package:nike/data/models/cart.dart';
import 'package:nike/data/models/cart_item.dart';
import 'package:nike/data/models/cart_response.dart';
import 'package:nike/data/source/cart_datasource.dart';

final CartRepository cartRepository =
    CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository {
  Future<Cart> add(int productId);
  Future<Cart> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<CartResponse> getAll();
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);
  @override
  Future<Cart> add(int productId) => dataSource.add(productId);

  @override
  Future<Cart> changeCount(int cartItemId, int count) {
    // TODO: implement changeCount
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<CartResponse> getAll() => dataSource.getAll();
}
