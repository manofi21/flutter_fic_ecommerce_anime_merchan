import 'package:flutter_fic_ecommerce_warung_comicon/core/errors/failure.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/result.dart';

import '../../../../core/use_cases/future_result_use_case.dart';
import '../entities/product_item.dart';
import '../repos/product_repo.dart';

class GetProductRemote extends FutureResultUseCase<List<ProductItem>, NoParams> {
  final ProductRepo productRepo;
  GetProductRemote(this.productRepo);

  @override
  Future<Result<List<ProductItem>, Failure>> processCall(NoParams params) async {
    try {
      final getListProduct = await productRepo.getProductFromApi();
      return Ok(getListProduct);
    } on ProductFailure {
      rethrow;
    } on UnknownFailure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Occure in Get Product Remote Use Cases : ${e.toString()}');
    }
  }
} 