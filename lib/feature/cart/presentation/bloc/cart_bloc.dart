import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import '../../../product/domain/entities/product_item.dart';
import '../../domain/cart_product.dart';

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

          // Update Product
          final updatePriceProduct = addingCountItem *
              convertToProductItem.productItem.productPrice.toDouble();
          final updateProduct = convertToProductItem.copyWith(
              productItemCount: addingCountItem,
              priceAfterCalculated: updatePriceProduct);
          currentListState[index] = updateProduct;
          emit(currentListState);
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
                    (convertToProductItem.productItem.productPrice *
                        addingCountItem);
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
  }

  void addProduct({required ProductItem productItem}) {
    add(CartAddProduct(productItem));
  }

  void discardProduct({required int productId}) {
    add(CartDiscardProduct(productId));
  }

  bool isProductExit(int productId) {
    return state.any((e) => e.productItem.productId == productId);
  }
}
