import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../product/domain/entities/product_item.dart';
import '../../domain/use_cases/get_searched_product.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final GetSearchedProduct getSearchedProduct;
  SearchProductBloc(this.getSearchedProduct) : super(SearchProductInitial()) {
    on<SendSearchProductEvent>(
      (event, emit) async {
        emit(SearchProductLoading());

        if (event.searchValue.isEmpty) {
          emit(SearchProductInitial());
          return;
        }

        final searchedProductUseCases =
            await getSearchedProduct(event.searchValue);
        final searchedProduct = searchedProductUseCases.when(
          ok: (ok) {
            return SearchProductLoaded(ok);
          },
          err: (err) {
            return SearchProductError(err.message);
          },
        );

        emit(searchedProduct);
      },
    );
  }

  void onSearchProduct(String searchValue) {
    add(SendSearchProductEvent(searchValue));
  }
}
