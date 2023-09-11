import 'package:bloc/bloc.dart';

import '../../../domain/use_cases/update_choosed_address_user_select.dart';
import '../list_address/list_address_cubit.dart';

part 'update_choosed_address_state.dart';

class UpdateChoosedAddressCubit extends Cubit<UpdateChoosedAddressState> {
  final UpdateChoosedAddressUserSelect updateChoosedAddressUserSelect;
  final ListAddressCubit? listAddressCubit;
  UpdateChoosedAddressCubit(
      this.updateChoosedAddressUserSelect, this.listAddressCubit)
      : super(UpdateChoosedAddressState());

  Future<void> onChangeSelectedAddress() async {
    emit(UpdateChoosedAddressState.onLoading());

    final addressId = listAddressCubit?.state.idSelectedAddress;
    if (addressId == null) {
      emit(
        state.onInsert(false, "ID Address yang ditermia null, Periksa Kembali"),
      );
      return;
    }
    final getChoosedAddressUseCases =
        await updateChoosedAddressUserSelect(addressId);
    final getChoosedAddressState = getChoosedAddressUseCases.when(
      ok: (ok) {
        if (!ok) {
          return state.onInsert(false, "Nilai yang diterima false, Periksa Kembali");
        }
        return state.onInsert(ok);
      },
      err: (err) {
        return state.onInsert(false, err.message);
      },
    );

    emit(getChoosedAddressState);
  }
}
