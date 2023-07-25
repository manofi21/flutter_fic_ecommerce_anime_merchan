import 'package:flutter/services.dart';

import '../errors/failure.dart';
import '../result_handler/result.dart';

abstract class FutureResultUseCase<ReturnType, ParameterType> {
  Future<Result<ReturnType, Failure>> call(ParameterType params) async {
    try {
      final result = await processCall(params);
      return result.when(
        ok: (value) => Ok(value),
        err: (failure) {
          return Err(failure);
        },
      );
    } catch (e) {
      if (e is PlatformException) {
        return Err(UnknownFailure(e.message ?? e.details));
      }
      return Err(UnknownFailure(e.toString()));
    }
  }

  /// Process call method in abstraction.
  Future<Result<ReturnType, Failure>> processCall(ParameterType params);
}
