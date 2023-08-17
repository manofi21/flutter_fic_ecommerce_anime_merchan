import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/address/domain/entities/address_entities.dart';

import '../../../address/domain/use_cases/get_list_address_user.dart';

part 'address_checkout_event.dart';
part 'address_checkout_state.dart';

class AddressCheckoutBloc
    extends Bloc<AddressCheckoutEvent, AddressCheckoutState> {
  final GetListAddressUser getListAddressUser;
  AddressCheckoutBloc(this.getListAddressUser)
      : super(AddressCheckoutInitial()) {
    on<AddressGetCheckoutEvent>(
      (event, emit) async {
        emit(AddressCheckoutLoading());

        final getAddressUseCases = getListAddressUser(NoParams());
        final getDataAddress = await getAddressUseCases;
        final getState = getDataAddress.when<AddressCheckoutState>(
          ok: (ok) {
            return AddressCheckoutLoaded(ok);
          },
          err: (err) {
            return AddressCheckoutError(err.message);
          },
        );

        emit(getState);
      },
    );
  }

  AddressEntities? getSelectedAddress() {
    final currentState = state;
    if (currentState is AddressCheckoutLoaded) {
      return currentState.listAddress.firstWhereOrNull((e) => e.isChoosedAddress);
    }

    return null;
  }
}
