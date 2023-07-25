import '../errors/exceptions.dart';
import 'http_exception.dart';

HttpException? statusCodeHandler(int statusCode) {
  if (statusCode == 400) {
    return BadRequestException();
  }

  if (statusCode == 401) {
    return UnauthorizedException();
  }

  // Don't Have Access
  if (statusCode == 403) {
    return ForbiddenException();
  }

  if (statusCode == 404) {
    return NotFoundException();
  }

  if (statusCode == 500) {
    return InternalServerErrorException();
  }

  if (statusCode == 503) {
    return ServiceUnavailableException();
  }

  if (statusCode == 504) {
    return GatewayTimeoutException();
  }

  if (statusCode == 429) {
    return TooManyRequestsException();
  }

  if (statusCode == 4001) {
    return TokenExpiredException();
  }

  if (statusCode == 4100) {
    return MissingParametersException();
  }

  return null;
}
