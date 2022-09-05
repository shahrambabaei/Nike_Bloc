part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;
  final bool isRefreshing;

  const CartStarted(this.authInfo, {this.isRefreshing = false});
}

class CartDeleteButtonClick extends CartEvent {
  final int cartItemId;

  const CartDeleteButtonClick(this.cartItemId);
  @override
  List<Object> get props => [cartItemId];
}

class CartAuthInfoChanged extends CartEvent {
  final AuthInfo? authInfo;

  const CartAuthInfoChanged(this.authInfo);
}

class CartIncreaseCountButtonClicked extends CartEvent {
  final int cartItemId;

  const CartIncreaseCountButtonClicked(this.cartItemId);
  @override
  List<Object> get props => [cartItemId];
}

class CartDecreaseCountButtonCicked extends CartEvent {
  final int cartItemId;

  const CartDecreaseCountButtonCicked(this.cartItemId);
  @override
  List<Object> get props => [cartItemId];
}
