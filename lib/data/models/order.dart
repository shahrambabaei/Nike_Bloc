import 'package:nike/data/models/product.dart';

class CreateOrderResult {
  final int orderId;
  final String bankGatewayUrl;

  CreateOrderResult(this.orderId, this.bankGatewayUrl);
  CreateOrderResult.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        bankGatewayUrl = json['bank_gateway_url'];
}

class CreateOrderParams {
  final String firstName;
  final String lastName;
  final String postalCode;
  final String mobile;
  final String address;
  final PaymentMethod paymentMethod;

  CreateOrderParams(this.firstName, this.lastName, this.postalCode, this.mobile,
      this.address, this.paymentMethod);
}

enum PaymentMethod {
  online,
  cashOnDelivery;
}

class OrderEntiry {
  final int id;
  final int payablePrice;
  final List<ProductEntity> items;

  OrderEntiry(this.id, this.payablePrice, this.items);
  OrderEntiry.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        payablePrice = json['payable'],
        items = (json['order_items'] as List)
            .map((item) => ProductEntity.fromJson(item['product']))
            .toList();
}
