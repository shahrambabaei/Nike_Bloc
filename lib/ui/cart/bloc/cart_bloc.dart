import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nike/configs/exceptions.dart';
import 'package:nike/data/models/authinfo.dart';
import 'package:nike/data/models/cart_response.dart';
import 'package:nike/data/repo/cart_repository.dart';
import 'package:nike/ui/cart/widgest/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        final authInfo = event.authInfo;
        if (authInfo == null || authInfo.accesstoken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          await loadCartItem(emit, event.isRefreshing);
        }
      } else if (event is CartDeleteButtonClick) {
        try {
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            final index = successState.cartResponse.cartItems
                .indexWhere((element) => element.id == event.cartItemId);
            successState.cartResponse.cartItems[index].deleteButtonLoading =
                true;
            emit(CartSuccess(successState.cartResponse));
          }
          await Future.delayed(const Duration(seconds: 1));
          await cartRepository.delete(event.cartItemId);
          cartRepository.count();
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            successState.cartResponse.cartItems
                .removeWhere((element) => element.id == event.cartItemId);
            if (successState.cartResponse.cartItems.isEmpty) {
              emit(CartEmpty());
            } else {
              emit(calculatePriceinfo(successState.cartResponse));
            }
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      } else if (event is CartAuthInfoChanged) {
        final authInfo = event.authInfo;
        if (authInfo == null || authInfo.accesstoken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          if (state is CartAuthRequired) {
            await loadCartItem(emit, false);
          }
        }
      } else if (event is CartIncreaseCountButtonClicked ||
          event is CartDecreaseCountButtonCicked) {
        try {
          int cartItemId = 0;
          if (event is CartIncreaseCountButtonClicked) {
            cartItemId = event.cartItemId;
          } else if (event is CartDecreaseCountButtonCicked) {
            cartItemId = event.cartItemId;
          }
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            final index = successState.cartResponse.cartItems
                .indexWhere((element) => element.id == cartItemId);
            successState.cartResponse.cartItems[index].changeCountLoading =
                true;
            emit(CartSuccess(successState.cartResponse));

            await Future.delayed(const Duration(seconds: 1));
            final newCount = event is CartIncreaseCountButtonClicked
                ? ++successState.cartResponse.cartItems[index].count
                : --successState.cartResponse.cartItems[index].count;
            await cartRepository.changeCount(cartItemId, newCount);
            await cartRepository.count();
            successState.cartResponse.cartItems
                .firstWhere((element) => element.id == cartItemId)
              ..count = newCount
              ..changeCountLoading = false;

            emit(calculatePriceinfo(successState.cartResponse));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    });
  }

  Future<void> loadCartItem(Emitter<CartState> emit, bool isRefreshing) async {
    try {
      if (!isRefreshing) {
        emit(CartLoading());
      }
      final result = await cartRepository.getAll();
      if (result.cartItems.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartSuccess(result));
      }
    } catch (e) {
      emit(CartError(AppException()));
    }
  }

  CartSuccess calculatePriceinfo(CartResponse cartResponse) {
    int payablePrice = 0;
    int totalPrice = 0;
    int shippingPrice = 0;
    cartResponse.cartItems.forEach((cartItem) {
      payablePrice += cartItem.product.price * cartItem.count;
      totalPrice += cartItem.product.previousPrice * cartItem.count;
    });
    shippingPrice += payablePrice > 300000 ? 0 : 30000;
    cartResponse.totalPrice = totalPrice;
    cartResponse.payablePrice = payablePrice;
    cartResponse.shippingPrice = shippingPrice;
    return CartSuccess(cartResponse);
  }
}
