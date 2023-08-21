import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';

import '../../domain/entities/order_history_entity.dart';
import '../../domain/use_cases/get_order_history.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final GetOrderHistory getOrderHistory;
  OrderHistoryBloc(this.getOrderHistory) : super(OrderHistoryInitial()) {
    on<OrderHistoryLoadData>((event, emit) async {
      emit(OrderHistoryLoading());

      final historyOrderUseCases = await getOrderHistory(NoParams());
      final getHistoryOrderState = historyOrderUseCases.when(ok: (ok) {
        return OrderHistoryLoaded(ok);
      }, err: (err) {
        return OrderHistoryError(err.message);
      });

      emit(getHistoryOrderState);
    });
  }
}
