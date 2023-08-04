import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/product_item.dart';
import '../../domain/use_cases/get_product_remote.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductRemote getProductRemote;
  ProductBloc(this.getProductRemote) : super(ProductInitial()) {
    on<ProductEvent>(
      (event, emit) {},
    );

    on<ProductLoadedEvent>(
      (event, emit) async {
        emit(ProductStateLoading());

        final listProductCases = await getProductRemote(NoParams());
        try {
          listProductCases.when(ok: (ok) {
            emit(ProductStateLoaded(ok));
          }, err: (err) {
            if (err is UnknownFailure) {
              final errMsg = err.message.split(' : ');
              if (errMsg.isNotEmpty) {
                emit(ProductStateError(errMsg.last));
              }
            }

            if (err is ProductFailure) {
              emit(ProductStateError(err.message));
            }
          });
        } catch (err) {
          emit(ProductStateError(err.toString()));
        }
      },
    );
  }

  void loadProduct() {
    add(ProductLoadedEvent());
  }
}
