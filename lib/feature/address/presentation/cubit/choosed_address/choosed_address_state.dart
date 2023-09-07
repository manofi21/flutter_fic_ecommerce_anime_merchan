// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../domain/entities/address_entities.dart';

class ChoosedAddressState {
  final AddressEntities? successValue;
  final String msgError;
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final bool isInit;

  ChoosedAddressState({
    this.successValue,
    this.msgError = '',
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.isInit = true,
  });

  static ChoosedAddressState onSuccess(AddressEntities successValue) {
    return ChoosedAddressState(
      isLoading: false,
      isError: false,
      isInit: false,
      isSuccess: true,
      successValue: successValue,
    );
  }

  static ChoosedAddressState onError(String msgError) {
    return ChoosedAddressState(
      isLoading: false,
      isInit: false,
      isSuccess: false,
      isError: true,
      msgError: msgError,
    );
  }

  static ChoosedAddressState onLoading() {
    return ChoosedAddressState(
      isInit: false,
      isSuccess: false,
      isError: false,
      isLoading: true,
    );
  }

  static ChoosedAddressState init() {
    return ChoosedAddressState(
      isInit: true,
      isSuccess: false,
      isError: false,
      isLoading: false,
      msgError: '',
      successValue: null
    );
  }

  // ChoosedAddressState copyWith({
  //   ChoosedAddressEntities? successValue,
  //   String? msgError,
  //   bool? isLoading,
  //   bool? isError,
  //   bool? isSuccess,
  //   bool? isInit,
  // }) {
  //   return ChoosedAddressState(
  //     successValue: successValue ?? this.successValue,
  //     msgError: msgError ?? this.msgError,
  //     isLoading: isLoading ?? this.isLoading,
  //     isError: isError ?? this.isError,
  //     isSuccess: isSuccess ?? this.isSuccess,
  //     isInit: isInit ?? this.isInit,
  //   );
  // }
}
