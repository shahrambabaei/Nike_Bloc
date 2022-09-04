import 'package:nike/data/models/cart_item.dart';

class CartResponse {
   List<CartItemEntity> cartItems;
   int payablePrice;
   int totalPrice;
   int shippingPrice;

  CartResponse(
      this.cartItems, this.payablePrice, this.totalPrice, this.shippingPrice);
  CartResponse.fromJson(Map<String, dynamic> json)
      : cartItems = CartItemEntity.parseJsonArray(json['cart_items']),
        payablePrice = json['payable_price'],
        totalPrice = json['total_price'],
        shippingPrice = json['shipping_cost'];
}
