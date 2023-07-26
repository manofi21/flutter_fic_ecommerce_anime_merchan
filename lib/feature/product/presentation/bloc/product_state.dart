part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductStateError extends ProductState {
  final String message;
  const ProductStateError(this.message);
}

class ProductStateLoaded extends ProductState {
  final List<ProductItem> listProduct;
  const ProductStateLoaded(this.listProduct);
}

class ProductStateLoading extends ProductState {}