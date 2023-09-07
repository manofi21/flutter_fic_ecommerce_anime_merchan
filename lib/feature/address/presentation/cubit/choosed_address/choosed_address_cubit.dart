import 'package:bloc/bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';

import '../../../domain/use_cases/get_choosed_address_user.dart';
import 'choosed_address_state.dart';

class ChoosedAddressCubit extends Cubit<ChoosedAddressState> {
  final GetChoosedAddressUser getChoosedAddressUser;
  ChoosedAddressCubit(this.getChoosedAddressUser)
      : super(ChoosedAddressState.init());

  Future<void> onGetChoosedAddress() async {
    emit(ChoosedAddressState.onLoading());

    final getChoosedAddressUseCases = await getChoosedAddressUser(NoParams());
    final getChoosedAddressState = getChoosedAddressUseCases.when(
      ok: (ok) {
        if (ok != null) {
          return ChoosedAddressState.onSuccess(ok);
        }

        return ChoosedAddressState.onError("Data yang diterima ternyata Null, Perika kembali");
      },
      err: (err) {
        print(err.message);
        return ChoosedAddressState.onError(err.message);
      },
    );

    emit(getChoosedAddressState);
  }
}
