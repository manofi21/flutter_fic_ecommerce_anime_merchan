import '../../../../core/errors/failure.dart';
import '../../../../core/result_handler/result.dart';
import '../../../../core/use_cases/future_result_use_case.dart';
import '../repos/address_repo.dart';

class UpdateChoosedAddressUserSelect extends FutureResultUseCase<bool, int> {
  final AddressRepo productRepo;
  UpdateChoosedAddressUserSelect(this.productRepo);

  @override
  Future<Result<bool, Failure>> processCall(int params) async {
    try {
      final getListAddress = await productRepo.updateChoosedAddressUserSelect(params);
      return Ok(getListAddress);
    } on Failure {
      rethrow;
    } catch (e, stackTrace) {
      // Mau di return Err atau langsung throw pun juga bisa
      throw UnknownFailure('Occure in Update Choosed Address User Select : ${e.toString()}', stackTrace);
    }
  }
} 