part of 'update_choosed_address_cubit.dart';

class UpdateChoosedAddressState {
  final bool isLoading;
  final bool isInit;
  final String msgError;
  final bool? isCreateSuccess;

  UpdateChoosedAddressState({
    this.isLoading = false,
    this.isInit = true,
    this.msgError = '',
    this.isCreateSuccess,
  });

  static UpdateChoosedAddressState onLoading() {
    return UpdateChoosedAddressState(
      isLoading: true,
      isInit: false,
    );
  }

  UpdateChoosedAddressState onInsert(bool isSucees, [String? msgError]) {
    return UpdateChoosedAddressState(
      isLoading: false,
      isInit: false,
      isCreateSuccess: isSucees,
      msgError: msgError ?? this.msgError,
    );
  }
}
