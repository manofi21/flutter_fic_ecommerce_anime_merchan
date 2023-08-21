part of 'order_history_bloc.dart';

class OrderHistoryState extends Equatable {
  const OrderHistoryState();
  
  @override
  List<Object> get props => [];
}

class OrderHistoryInitial extends OrderHistoryState {}

class OrderHistoryLoading extends OrderHistoryState {}

class OrderHistoryError extends OrderHistoryState {
  final String message;
  const OrderHistoryError(this.message);
}

class OrderHistoryLoaded extends OrderHistoryState {
  final List<OrderHistoryEntity> listOrderHistory;
  const OrderHistoryLoaded(this.listOrderHistory);
}

extension OrderHistoryStateBool on OrderHistoryState {
  bool get isLoading => this is OrderHistoryLoading;

  bool get isError => this is OrderHistoryError;
}