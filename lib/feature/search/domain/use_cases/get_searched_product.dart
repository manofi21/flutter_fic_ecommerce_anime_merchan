import 'package:flutter_fic_ecommerce_warung_comicon/core/errors/failure.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/result.dart';

import '../../../../core/use_cases/future_result_use_case.dart';
import '../../../product/domain/entities/product_item.dart';
import '../../../product/domain/repos/product_repo.dart';

class GetSearchedProduct extends FutureResultUseCase<List<ProductItem>, String> {
  final ProductRepo productRepo;
  GetSearchedProduct(this.productRepo);

  @override
  Future<Result<List<ProductItem>, Failure>> processCall(String params) async {
    try {
      final getListProduct = await productRepo.getSearchFromApi(params);
      return Ok(getListProduct);
    } on Failure {
      rethrow;
    } catch (e, stackTrace) {
      // Mau di return Err atau langsung throw pun juga bisa
      throw UnknownFailure('Occure in Get Product Remote Use Cases : ${e.toString()}', stackTrace);
    }
  }
} 