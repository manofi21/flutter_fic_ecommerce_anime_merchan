import '../entities/address_entities.dart';
import '../entities/choosed_address_entities.dart';

abstract class AddressRepo {
  Future<List<AddressEntities>> getListAddressUser();
  Future<ChoosedAddressEntities?> getChoosedAddressUser();
}