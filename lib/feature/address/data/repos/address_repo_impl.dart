import 'package:flutter_fic_ecommerce_warung_comicon/feature/address/domain/entities/address_entities.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/address/domain/repos/address_repo.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../data_source/address_remote_data_source.dart';

class AddressRepoImpl extends AddressRepo {
  final AddressRemoteDataSource addressRemoteDataSource;
  AddressRepoImpl(this.addressRemoteDataSource);
  @override
  Future<List<AddressEntities>> getListAddressUser() async {
    try {
      final getAddressFromRemote =
          await addressRemoteDataSource.getListAddress();
      final toListEntities = getAddressFromRemote
          .map((e) => AddressEntities(
              id: e.id,
              labelAddress: e.attributes.labelAddress,
              fullAddress: e.attributes.fullAddress,
              detailAddress: e.attributes.detailAddress,
              recipientName: e.attributes.recipientName,
              phoneNumber: e.attributes.phoneNumber,
              isMainAddress: e.attributes.isMainAddress))
          .toList();
      return toListEntities;
    } on HttpException catch (e) {
      throw AddressFailure(e.message);
    } on UnknownException catch (e) {
      throw AddressFailure(e.message);
    } catch (e, stackTrace) {
      throw UnknownFailure(
          'Occure in Address Repo : ${e.toString()}', stackTrace);
    }
  }
}
