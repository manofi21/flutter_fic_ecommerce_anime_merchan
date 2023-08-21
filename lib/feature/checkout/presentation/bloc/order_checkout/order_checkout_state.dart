part of 'order_checkout_cubit.dart';

enum OrderCheckoutState{
  initial, loading, ordered, error
}

extension OrderCheckoutStateBool on OrderCheckoutState {
  bool get isLoading => this == OrderCheckoutState.loading;
}