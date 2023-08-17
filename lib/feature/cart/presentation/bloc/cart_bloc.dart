import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:equatable/equatable.dart';

import '../../../product/domain/entities/product_item.dart';
import '../../domain/entities/cart_product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(<CartProduct>[]) {
    on<CartAddProduct>(
      (event, emit) {
        final currentListState = state;

        // For updating state
        emit([]);
        final productItem = event.productItem;
        final convertToProductItem = CartProduct(
          productItem: productItem,
          productItemCount: 1,
          priceAfterCalculated: productItem.productPrice.toDouble(),
        );

        final listState = currentListState..add(convertToProductItem);
        emit(listState);
        return;
      },
    );

    on<CartIncrementProduct>(
      (event, emit) {
        final currentListState = state;

        emit([]);

        final productId = event.productId;
        // Get Product By Product Id
        final convertToProductItem = currentListState
            .firstWhereOrNull((e) => e.productItem.productId == productId);

        if (convertToProductItem != null) {
          // Get Index of the product
          final index = currentListState
              .indexWhere((e) => e.productItem.productId == productId);

          // Adding Product
          final addingCountItem = convertToProductItem.productItemCount + 1;

          if (addingCountItem > convertToProductItem.productItem.quantity) {
            event.onHitLimitQuality();
            emit(currentListState);
          }

          if (addingCountItem <= convertToProductItem.productItem.quantity) {
            // Update Product
            final updatePriceProduct =
                convertToProductItem.priceAfterCalculated +
                    convertToProductItem.productItem.productPrice;

            final updateProduct = convertToProductItem.copyWith(
                productItemCount: addingCountItem,
                priceAfterCalculated: updatePriceProduct);
            currentListState[index] = updateProduct;
            emit(currentListState);
          }
        }
      },
    );

    on<CartDecrementProduct>(
      (event, emit) {
        final currentListState = state;

        emit([]);

        final productId = event.productId;

        // Get Product By Product Id
        final convertToProductItem = currentListState
            .firstWhereOrNull((e) => e.productItem.productId == productId);
        if (convertToProductItem != null) {
          // Get Index of the product
          final index = currentListState.indexWhere(
            (e) => e.productItem.productId == productId,
          );

          // Subtracing Product
          final addingCountItem = convertToProductItem.productItemCount - 1;

          if (addingCountItem == 0) {
            currentListState.removeAt(index);
            emit(currentListState);
          }

          if (addingCountItem > 0) {
            // Update Product
            final updatePriceProduct =
                convertToProductItem.priceAfterCalculated -
                    convertToProductItem.productItem.productPrice;
            final updateProduct = convertToProductItem.copyWith(
                productItemCount: addingCountItem,
                priceAfterCalculated: updatePriceProduct);
            currentListState[index] = updateProduct;
            emit(currentListState);
          }
        }
      },
    );

    /// Looks redudan. Consider to delete
    on<CartDiscardProduct>(
      (event, emit) {
        final currentListState = state;
        emit([]);
        final productId = event.productId;

        // Get Index of the product
        final index = currentListState
            .indexWhere((e) => e.productItem.productId == productId);

        currentListState.removeAt(index);
        emit(currentListState);
      },
    );

    on<CartClickCheckbox>(
      (event, emit) {
        final currentListState = state;
        emit([]);

        final productId = event.productId;

        final convertToProductItem = currentListState
            .firstWhereOrNull((e) => e.productItem.productId == productId);

        if (convertToProductItem != null) {
          final changeCheckedValue = convertToProductItem.copyWith(
            isChecked: event.afterClicked,
          );

          final index = currentListState.indexWhere(
            (e) => e.productItem.productId == productId,
          );

          currentListState[index] = changeCheckedValue;
          emit(currentListState);
        }
      },
    );

    on<CartCleanProduct>((_, emit) => emit([]));
  }

  // Function for trigger event

  void addProduct({required ProductItem productItem}) {
    add(CartAddProduct(productItem));
  }

  void discardProduct({required int productId}) {
    add(CartDiscardProduct(productId));
  }
  // CartIncrementProduct

  void incrementProduct(
      {required int productId, required void Function() onHitLimitQuality}) {
    add(CartIncrementProduct(productId, onHitLimitQuality));
  }

  void decrementProduct({required int productId}) {
    add(CartDecrementProduct(productId));
  }

  void clearCartList() => add(CartCleanProduct());

  void onChangeCheckValueById(int productId, bool clicked) {
    add(CartClickCheckbox(productId, clicked));
  }

  /// Function for access State

  bool isProductExit(int productId) {
    return state.any((e) => e.productItem.productId == productId);
  }

  int countProductInCart(int productId) {
    return state
            .firstWhereOrNull((e) => e.productItem.productId == productId)
            ?.productItemCount ??
        0;
  }

  String getAllTotalCheckPriceProduct() {
    final listWhereValueChecked = state.where((e) => e.isChecked).toList();
    final listAllItem =
        listWhereValueChecked.map((e) => e.priceAfterCalculated).toList();
    final reduceValueItem =
        listAllItem.isEmpty ? 0.0 : listAllItem.reduce((v, e) => v + e);

    if (reduceValueItem == 0) {
      return 'Rp -';
    }

    final idrFormatter = CurrencyFormatterSettings(
      symbol: 'Rp',
      thousandSeparator: '.',
      decimalSeparator: ',',
    );
    final stringCurrency = CurrencyFormatter.format(
      reduceValueItem,
      idrFormatter,
      decimal: 0,
    );
    return stringCurrency;
  }

  bool getCheckValueById(int productId) {
    final convertToProductItem =
        state.firstWhereOrNull((e) => e.productItem.productId == productId);
    return convertToProductItem?.isChecked ?? false;
  }

  List<CartProduct> checkedList() => state.where((e) => e.isChecked).toList();
}
