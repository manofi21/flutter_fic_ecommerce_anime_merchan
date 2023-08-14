import '../../../../core/errors/failure.dart';
import '../../../../core/result_handler/result.dart';
import '../../../../core/use_cases/future_result_use_case.dart';
import '../../data/model/order_result_model.dart';
import '../entities/order_request_entities.dart';
import '../repos/order_repo.dart';

class CheckoutOrderProduct extends FutureResultUseCase<OrderResultModel, OrderRequestEntities> {
  final OrderRepo orderRepo;
  CheckoutOrderProduct(this.orderRepo);

  @override
  Future<Result<OrderResultModel, Failure>> processCall(OrderRequestEntities params) async {
    try {
      final getListProduct = await orderRepo.orderProduct(params);
      return Ok(getListProduct);
    } on Failure {
      rethrow;
    } catch (e, stackTrace) {
      // Mau di return Err atau langsung throw pun juga bisa
      throw UnknownFailure('Occure in Checkout Order Product : ${e.toString()}', stackTrace);
    }
  }
} 