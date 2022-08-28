import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/configs/exceptions.dart';
import 'package:nike/data/models/authinfo.dart';
import 'package:nike/data/models/cart_response.dart';
import 'package:nike/data/repo/cart_repository.dart';

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
          await loadCartItem(emit);
        }
      } else if (event is CartDeleteButton) {
      } else if (event is CartAuthInfoChanged) {
        final authInfo = event.authInfo;
        if (authInfo == null || authInfo.accesstoken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          if (state is CartAuthRequired) {
            await loadCartItem(emit);
          }
        }
      }
    });
  }

  Future<void> loadCartItem(Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
      final result = await cartRepository.getAll();
      emit(CartSuccess(result));
    } catch (e) {
      emit(CartError(AppException()));
    }
  }
}
