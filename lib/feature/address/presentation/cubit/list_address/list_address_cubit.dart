import 'package:bloc/bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';

import '../../../domain/use_cases/get_list_address_user.dart';
import '../choosed_address/choosed_address_cubit.dart';
import 'list_address_state.dart';

class ListAddressCubit extends Cubit<ListAddressState> {
  final GetListAddressUser getListAddressUser;
  final ChoosedAddressCubit? choosedAddressCubit;
  ListAddressCubit(this.getListAddressUser, this.choosedAddressCubit) : super(ListAddressState.init());

  Future<void> onGetListAddress() async {
    emit(ListAddressState.onLoading());

    final getChoosedAddressUseCases = await getListAddressUser(NoParams());
    final getChoosedAddressState = getChoosedAddressUseCases.when(
      ok: (ok) {
        final selectedId = choosedAddressCubit?.state.successValue?.id;
        return ListAddressState.onSuccess(ok, selectedId: selectedId);
      },
      err: (err) {
        return ListAddressState.onError(err.message);
      },
    );

    emit(getChoosedAddressState);
  }
  void onUpdateSelectedId(int id) {
    emit(state.updateSelectedId(id));
  }
  
}
