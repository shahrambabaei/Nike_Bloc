
import 'package:dio/dio.dart';
import 'package:nike/configs/exceptions.dart';
import 'package:nike/data/product.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);
  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final response = await httpClient.get('product/list?sort=$sort');
    validateResponse(response);
    final products = <ProductEntity>[];
    (response.data as List).forEach((item) {
      products.add(ProductEntity.fromJson(item));
    });
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get('product/search?q=$searchTerm');
    validateResponse(response);
    final products = <ProductEntity>[];
    (response.data as List).forEach((item) {
      products.add(ProductEntity.fromJson(item));
    });
    return products;
  }

  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
