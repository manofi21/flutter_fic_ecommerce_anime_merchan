import '../entities/add_address_entities.dart';
import '../entities/address_entities.dart';

abstract class AddressRepo {
  Future<List<AddressEntities>> getListAddressUser();
  Future<AddressEntities?> getChoosedAddressUser();
  Future<bool> addAddressUserInput(AddAddressEntities addAddress);
}