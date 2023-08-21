import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/result_handler/result.dart';
import '../../../../core/use_cases/future_result_use_case.dart';
import '../entities/order_history_entity.dart';
import '../repos/order_history_repo.dart';

class GetOrderHistory extends FutureResultUseCase<List<OrderHistoryEntity>, NoParams> {
  final OrderHistoryRepo orderHistoryRepo;
  GetOrderHistory(this.orderHistoryRepo);

  @override
  Future<Result<List<OrderHistoryEntity>, Failure>> processCall(NoParams params) async {
    try {
      final getListProduct = await orderHistoryRepo.orderToHistoryEntities();
      return Ok(getListProduct);
    } on Failure {
      rethrow;
    } catch (e, stackTrace) {
      // Mau di return Err atau langsung throw pun juga bisa
      throw UnknownFailure('Occure in Checkout Order Product : ${e.toString()}', stackTrace);
    }
  }
} 