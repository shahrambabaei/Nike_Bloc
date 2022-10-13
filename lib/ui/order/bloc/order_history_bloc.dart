import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/configs/exceptions.dart';
import 'package:nike/data/models/order.dart';
import 'package:nike/data/models/product.dart';
import 'package:nike/data/repo/order_repository.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final IOrderRepository orderRepository;
  OrderHistoryBloc(this.orderRepository) : super(OrderHistoryLoading()) {
    on<OrderHistoryEvent>((event, emit) async {
      if (event is OrderHistoryStarted) {
        try {
          emit(OrderHistoryLoading());
       final orders=   await orderRepository.getOrders();
       emit(OrderHistorySuccess(orders));
        } catch (e) {
          emit(OrderHistoryError(AppException()));
        }
      }
    });
  }
}
