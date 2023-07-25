import '../errors/exceptions.dart';

class BadRequestException extends HttpException {
  BadRequestException() : super('Permintaan tidak dapat dipahami oleh server karena kesalahan sintaks dalam permintaan.');
}

class UnauthorizedException extends HttpException {
  UnauthorizedException() : super('Permintaan memerlukan otentikasi pengguna, dan pengguna belum melakukan otentikasi atau otentikasinya gagal.');
}

class ForbiddenException extends HttpException {
  ForbiddenException() : super('Server telah memahami permintaan, tetapi server menolak untuk mengizinkan akses ke sumber daya yang diminta.');
}

class NotFoundException extends HttpException {
  NotFoundException() : super('Server tidak dapat menemukan sumber daya yang diminta.');
}

class InternalServerErrorException extends HttpException {
  InternalServerErrorException() : super(' Server mengalami situasi yang tidak terduga yang menghalangi pemenuhan permintaan.');
}

class ServiceUnavailableException extends HttpException {
  ServiceUnavailableException() : super('Server tidak siap untuk menangani permintaan. Layanan mungkin sementara tidak tersedia.');
}

class GatewayTimeoutException extends HttpException {
  GatewayTimeoutException() : super('Server bertindak sebagai gateway atau proxy, tetapi tidak menerima tanggapan tepat waktu dari server upstream.');
}

class TooManyRequestsException extends HttpException {
  TooManyRequestsException() : super('Pengguna telah melebihi batas tingkat permintaan yang diizinkan pada periode waktu tertentu.');
}

class TokenExpiredException extends HttpException {
  TokenExpiredException() : super('Permintaan tidak dapat diotentikasi karena token yang digunakan telah kadaluarsa.');
}

class MissingParametersException extends HttpException {
  MissingParametersException() : super(' Permintaan tidak dapat diproses karena parameter yang diperlukan tidak disediakan.');
}