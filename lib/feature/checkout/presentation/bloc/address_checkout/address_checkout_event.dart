part of 'address_checkout_bloc.dart';

abstract class AddressCheckoutEvent extends Equatable {
  const AddressCheckoutEvent();

  @override
  List<Object> get props => [];
}

class AddressGetCheckoutEvent extends AddressCheckoutEvent {}

class AddressPickCheckoutEvent extends AddressCheckoutEvent {}