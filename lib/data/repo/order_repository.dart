import 'package:nike/configs/http_client.dart';
import 'package:nike/data/models/order.dart';
import 'package:nike/data/source/order_datasource.dart';

final OrderRepository orderRepository =
    OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository extends IOrderDataSource {}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource dataSource;

  OrderRepository(this.dataSource);
  @override
  Future<CreateOrderResult> create(CreateOrderParams params) =>
      dataSource.create(params);
}
