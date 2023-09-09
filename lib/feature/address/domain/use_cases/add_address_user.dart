import '../../../../core/errors/failure.dart';
import '../../../../core/result_handler/result.dart';
import '../../../../core/use_cases/future_result_use_case.dart';
import '../entities/add_address_entities.dart';
import '../repos/address_repo.dart';

class AddAddressUser extends FutureResultUseCase<bool, AddAddressEntities> {
  final AddressRepo productRepo;
  AddAddressUser(this.productRepo);

  @override
  Future<Result<bool, Failure>> processCall(AddAddressEntities params) async {
    try {
      final getListAddress = await productRepo.addAddressUserInput(params);
      return Ok(getListAddress);
    } on Failure {
      rethrow;
    } catch (e, stackTrace) {
      // Mau di return Err atau langsung throw pun juga bisa
      throw UnknownFailure('Occure in Get Choosed Address User Use Cases : ${e.toString()}', stackTrace);
    }
  }
} 