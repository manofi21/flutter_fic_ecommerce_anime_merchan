import '../errors/exceptions.dart';
import '../errors/failure.dart';

Failure exceptionToFailure<S extends Failure>(BaseExceptions exception, S Function(String) failure) {
  if (exception is HttpException) {
    return failure(exception.message);
  }

  if (exception is UnknownException) {
    return UnknownFailure(exception.message);
  }

  return const NoMessageFailure();
}