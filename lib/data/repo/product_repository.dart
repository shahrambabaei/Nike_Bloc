import 'package:dio/dio.dart';
import 'package:nike/data/product.dart';
import 'package:nike/data/source/product_datasource.dart';

final httpClient =
    Dio(BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'));

final productRepository =
    ProductRepository(ProductRemoteDataSource(httpClient));

abstract class IProductRepository {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepository(this.dataSource);
  @override
  Future<List<ProductEntity>> getAll(int sort) => dataSource.getAll(sort);

  @override
  Future<List<ProductEntity>> search(String searchTerm) =>
      dataSource.search(searchTerm);
}
