import 'package:nike/configs/http_client.dart';
import 'package:nike/data/models/order.dart';
import 'package:nike/data/models/payment_reciept.dart';
import 'package:nike/data/source/order_datasource.dart';

final orderRepository = OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository extends IOrderDataSource {}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource orderDataSource;

  OrderRepository(this.orderDataSource);
  @override
  Future<CreateOrderResult> create(CreateOrderParams params) =>
      orderDataSource.create(params);

  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) =>
      orderDataSource.getPaymentReceipt(orderId);

  @override
  Future<List<OrderEntiry>> getOrders() {
    return orderDataSource.getOrders();
  }
}
