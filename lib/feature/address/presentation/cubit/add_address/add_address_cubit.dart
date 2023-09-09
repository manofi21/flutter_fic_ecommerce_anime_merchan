import 'package:bloc/bloc.dart';

import '../../../domain/entities/add_address_entities.dart';
import '../../../domain/use_cases/add_address_user.dart';

part 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  final AddAddressUser addAddressUser;
  AddAddressCubit(this.addAddressUser) : super(AddAddressState());

  Future<void> onAddAddress(AddAddressEntities addAddress) async {
    emit(state.onLoading());

    final addAddressUseCases = await addAddressUser(addAddress);
    final addAddressUseCasesState = addAddressUseCases.when(
      ok: (success) {
        if (!success) {
          return state.onInsert(success, "Data yang diterima false, Periksa Kembali");
        }

        return state.onInsert(success);
      },
      err: (err) {
        return state.onInsert(false, err.message);
      },
    );

    emit(addAddressUseCasesState);
  }
}
