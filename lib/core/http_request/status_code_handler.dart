import '../errors/exceptions.dart';
import 'http_exception.dart';

HttpException? statusCodeHandler(int statusCode) {
  if (statusCode == 400) {
    return const BadRequestException();
  }

  if (statusCode == 401) {
    return const UnauthorizedException();
  }

  // Don't Have Access
  if (statusCode == 403) {
    return const ForbiddenException();
  }

  if (statusCode == 404) {
    return const NotFoundException();
  }

  if (statusCode == 500) {
    return const InternalServerErrorException();
  }

  if (statusCode == 503) {
    return const ServiceUnavailableException();
  }

  if (statusCode == 504) {
    return const GatewayTimeoutException();
  }

  if (statusCode == 429) {
    return const TooManyRequestsException();
  }

  if (statusCode == 4001) {
    return const TokenExpiredException();
  }

  if (statusCode == 4100) {
    return const MissingParametersException();
  }

  return null;
}
