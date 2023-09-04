part of 'search_product_bloc.dart';

class SearchProductState extends Equatable {
  const SearchProductState();
  
  @override
  List<Object> get props => [];
}

class SearchProductInitial extends SearchProductState {}

class SearchProductLoading extends SearchProductState {}

class SearchProductLoaded extends SearchProductState {
  final List<ProductItem> searchedListItem;
  const SearchProductLoaded(this.searchedListItem);
}

class SearchProductError extends SearchProductState {
  final String errorMsg;
  const SearchProductError(this.errorMsg);
}
