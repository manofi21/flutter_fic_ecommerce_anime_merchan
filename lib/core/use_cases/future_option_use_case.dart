import 'package:flutter/services.dart';

import '../errors/failure.dart';
import '../result_handler/option.dart';

abstract class FutureOptionUseCase<ParameterType> {
  Future<Option<Failure>> call(ParameterType params) async {
    try {
      final result = await processCall(params);
      return result.when(
        none: () => None(),
        error: (failure) {
          return Error(failure);
        },
      );
    } catch (e) {
      if (e is PlatformException) {
        return Error(UnknownFailure(e.message ?? e.details));
      }
      return Error(UnknownFailure(e.toString()));
    }
  }

  /// Process call method in abstraction.
  Future<Option<Failure>> processCall(ParameterType params);
}
