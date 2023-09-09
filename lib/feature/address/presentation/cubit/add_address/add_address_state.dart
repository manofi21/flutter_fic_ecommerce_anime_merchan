part of 'add_address_cubit.dart';

class AddAddressState {
  final bool isLoading;
  final bool isInit;
  final String msgError;
  final bool? isCreateSuccess;

  AddAddressState({
    this.isLoading = false,
    this.isInit = true,
    this.msgError = '',
    this.isCreateSuccess,
  });

  AddAddressState onLoading() {
    return AddAddressState(
      isLoading: true,
      isInit: false,
    );
  }

  AddAddressState onInsert(bool isSucees, [String? msgError]) {
    return AddAddressState(
      isLoading: false,
      isInit: false,
      isCreateSuccess: isSucees,
      msgError: msgError ?? this.msgError,
    );
  }
}
