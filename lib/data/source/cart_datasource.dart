import 'package:nike/data/models/cart.dart';
import 'package:dio/dio.dart';
import 'package:nike/data/models/cart_response.dart';

abstract class ICartDataSource {
  Future<Cart> add(int productId);
  Future<Cart> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<CartResponse> getAll();
}

class CartRemoteDataSource implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource(this.httpClient);
  @override
  Future<Cart> add(int productId) async {
    final response =
        await httpClient.post('cart/add', data: {'product_id': productId});
    return Cart.formJson(response.data);
  }

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
  Future<CartResponse> getAll() async {
    final response = await httpClient.get('cart/list');
    return CartResponse.fromJson(response.data);
  }
}
