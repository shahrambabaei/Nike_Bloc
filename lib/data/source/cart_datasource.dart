import 'package:nike/configs/http_client.dart';
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
  Future<Cart> changeCount(int cartItemId, int count) async {
    final response = await httpClient.post('cart/changeCount',
        data: {"cart_item_id": cartItemId, "count": count});
    return Cart.formJson(response.data);
  }

  @override
  Future<int> count() async {
    final response = await httpClient.get('cart/count');
    return response.data['count'];
  }

  @override
  Future<void> delete(int cartItemId) async {
    await httpClient.post('cart/remove', data: {'cart_item_id': cartItemId});
  }

  @override
  Future<CartResponse> getAll() async {
    final response = await httpClient.get('cart/list');
    return CartResponse.fromJson(response.data);
  }
}
