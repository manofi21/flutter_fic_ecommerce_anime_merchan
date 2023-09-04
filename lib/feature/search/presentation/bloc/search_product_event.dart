part of 'search_product_bloc.dart';

class SearchProductEvent extends Equatable {
  const SearchProductEvent();

  @override
  List<Object> get props => [];
}

class SendSearchProductEvent extends SearchProductEvent {
  final String searchValue;

  const SendSearchProductEvent(this.searchValue);
}