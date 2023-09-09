import 'package:flutter_fic_ecommerce_warung_comicon/feature/address/domain/entities/add_address_entities.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/address/domain/entities/address_entities.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/address/domain/repos/address_repo.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../data_source/address_remote_data_source.dart';
import '../model/add_address_model.dart';

class AddressRepoImpl extends AddressRepo {
  final AddressRemoteDataSource addressRemoteDataSource;
  AddressRepoImpl(this.addressRemoteDataSource);
  @override
  Future<List<AddressEntities>> getListAddressUser() async {
    try {
      final getAddressFromRemote =
          await addressRemoteDataSource.getListAddress();
      final toListEntities = getAddressFromRemote
          .map(
            (e) => AddressEntities(
              id: e.id,
              labelAddress: e.labelAddress,
              fullAddress: e.fullAddress,
              detailAddress: e.detailAddress,
              recipientName: e.recipientName,
              phoneNumber: e.phoneNumber,
              isMainAddress: e.isMainAddress,
              isChoosedAddress: e.isChoosedAddress,
            ),
          )
          .toList();
      return toListEntities;
    } on HttpException catch (e) {
      throw AddressFailure(e.message);
    } on UnknownException catch (e) {
      throw AddressFailure(e.message);
    } catch (e, stackTrace) {
      throw UnknownFailure(
          'Occure in Address Repo getListAddressUser : ${e.toString()}',
          stackTrace);
    }
  }

  @override
  Future<AddressEntities?> getChoosedAddressUser() async {
    try {
      final getAddressFromRemote =
          await addressRemoteDataSource.getChoosedAddress();
      if (getAddressFromRemote != null) {
        final e = getAddressFromRemote;
        return AddressEntities(
          id: e.id,
          labelAddress: e.labelAddress,
          fullAddress: e.fullAddress,
          detailAddress: e.detailAddress,
          recipientName: e.recipientName,
          phoneNumber: e.phoneNumber,
          isMainAddress: e.isMainAddress,
          isChoosedAddress: e.isChoosedAddress,
        );
      }
      return null;
    } on HttpException catch (e) {
      throw AddressFailure(e.message);
    } on UnknownException catch (e) {
      throw AddressFailure(e.message);
    } catch (e, stackTrace) {
      throw UnknownFailure(
          'Occure in Address Repo getChoosedAddressUser : ${e.toString()}',
          stackTrace);
    }
  }

  @override
  Future<bool> addAddressUserInput(AddAddressEntities addAddress) async {
    try {
      final addressRequestUser = AddAddressModel(
        data: AddAddressDataModel(
            labelAddress: addAddress.labelAddress,
            fullAddress: addAddress.fullAddress,
            detailAddress: addAddress.detailAddress,
            recipientName: addAddress.recipientName,
            phoneNumber: int.parse(addAddress.phoneNumber),
            isMainAddress: addAddress.isMainAddress,
            isChoosedAddress: addAddress.isChoosedAddress),
      );
      final getAddressFromRemote = await addressRemoteDataSource.addAddress(addressRequestUser);
      return getAddressFromRemote != null;
    } on HttpException catch (e) {
      throw AddressFailure(e.message);
    } on UnknownException catch (e) {
      throw AddressFailure(e.message);
    } catch (e, stackTrace) {
      throw UnknownFailure(
          'Occure in Address Repo addAddressUserInput : ${e.toString()}',
          stackTrace);
    }
  }
}
