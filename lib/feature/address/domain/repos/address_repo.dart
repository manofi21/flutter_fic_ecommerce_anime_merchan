import '../entities/address_entities.dart';

abstract class AddressRepo {
  Future<List<AddressEntities>> getListAddressUser();
  Future<AddressEntities?> getChoosedAddressUser();
}