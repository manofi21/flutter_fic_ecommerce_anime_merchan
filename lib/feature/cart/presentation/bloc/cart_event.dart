part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartAddProduct extends CartEvent {
  final ProductItem productItem;
  const CartAddProduct(this.productItem);
}

class CartIncrementProduct extends CartEvent {
  final int productId;
  final void Function() onHitLimitQuality;
  const CartIncrementProduct(this.productId, this.onHitLimitQuality);
}

class CartDecrementProduct extends CartEvent {
  final int productId;
  const CartDecrementProduct(this.productId);
}

class CartDiscardProduct extends CartEvent {
  final int productId;
  const CartDiscardProduct(this.productId);
}

class CartCleanProduct extends CartEvent {}

class CartClickCheckbox extends CartEvent {
  final int productId;
  final bool afterClicked;
  const CartClickCheckbox(this.productId, this.afterClicked);
}
