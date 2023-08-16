import '../../../../core/errors/failure.dart';
import '../../../../core/result_handler/no_params.dart';
import '../../../../core/result_handler/result.dart';
import '../../../../core/use_cases/future_result_use_case.dart';
import '../entities/address_entities.dart';
import '../repos/address_repo.dart';

class GetListAddressUser extends FutureResultUseCase<List<AddressEntities>, NoParams> {
  final AddressRepo productRepo;
  GetListAddressUser(this.productRepo);

  @override
  Future<Result<List<AddressEntities>, Failure>> processCall(NoParams params) async {
    try {
      final getListAddress = await productRepo.getListAddressUser();
      return Ok(getListAddress);
    } on Failure {
      rethrow;
    } catch (e, stackTrace) {
      // Mau di return Err atau langsung throw pun juga bisa
      throw UnknownFailure('Occure in Get list Address User Use Cases : ${e.toString()}', stackTrace);
    }
  }
} 