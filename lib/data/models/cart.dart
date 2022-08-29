

class Cart {
  final int productId;
  final int cartItemId;
  final int count;

  Cart(this.productId, this.cartItemId, this.count);
  Cart.formJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        cartItemId = json['id'], //  OR 'cart_item_id'
        count = json['count'];
}
