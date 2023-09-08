import '../../../domain/entities/address_entities.dart';

class ListAddressState {
  final List<AddressEntities> successValue;
  final String msgError;
  final int? idSelectedAddress;
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final bool isInit;

  ListAddressState({
    this.successValue = const [],
    this.msgError = '',
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.isInit = true,
    this.idSelectedAddress
  });

  static ListAddressState onSuccess(List<AddressEntities> successValue, {int? selectedId}) {
    return ListAddressState(
      isLoading: false,
      isError: false,
      isInit: false,
      isSuccess: true,
      successValue: successValue,
      idSelectedAddress: selectedId,
    );
  }

  static ListAddressState onError(String msgError) {
    return ListAddressState(
      isLoading: false,
      isInit: false,
      isSuccess: false,
      isError: true,
      msgError: msgError,
    );
  }

  static ListAddressState onLoading() {
    return ListAddressState(
      isInit: false,
      isSuccess: false,
      isError: false,
      isLoading: true,
    );
  }

  static ListAddressState init() {
    return ListAddressState(
      isInit: true,
      isSuccess: false,
      isError: false,
      isLoading: false,
      msgError: '',
      successValue: []
    );
  }

  ListAddressState updateSelectedId(int? selectedId) {
    return ListAddressState(
      isInit: isInit,
      isSuccess: isSuccess,
      isError: isError,
      isLoading: isLoading,
      msgError: msgError,
      successValue: successValue,
      idSelectedAddress: selectedId,
    );
  }

  // ListAddressState copyWith({
  //   ListAddressEntities? successValue,
  //   String? msgError,
  //   bool? isLoading,
  //   bool? isError,
  //   bool? isSuccess,
  //   bool? isInit,
  // }) {
  //   return ListAddressState(
  //     successValue: successValue ?? this.successValue,
  //     msgError: msgError ?? this.msgError,
  //     isLoading: isLoading ?? this.isLoading,
  //     isError: isError ?? this.isError,
  //     isSuccess: isSuccess ?? this.isSuccess,
  //     isInit: isInit ?? this.isInit,
  //   );
  // }
}
