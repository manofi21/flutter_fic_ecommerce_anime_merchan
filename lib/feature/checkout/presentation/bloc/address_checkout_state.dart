part of 'address_checkout_bloc.dart';

abstract class AddressCheckoutState extends Equatable {
  const AddressCheckoutState();
  
  @override
  List<Object> get props => [];
}

class AddressCheckoutInitial extends AddressCheckoutState {}

class AddressCheckoutLoading extends AddressCheckoutState {}

class AddressCheckoutLoaded extends AddressCheckoutState {
  final List<AddressEntities> listAddress;
  const AddressCheckoutLoaded(this.listAddress);
}

class AddressCheckoutError extends AddressCheckoutState {
  final String message;
  const AddressCheckoutError(this.message);
}
