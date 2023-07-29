import '../errors/exceptions.dart';

class BadRequestException extends HttpException {
  const BadRequestException() : super('Permintaan tidak dapat dipahami oleh server karena kesalahan sintaks dalam permintaan.');
}

class UnauthorizedException extends HttpException {
  const UnauthorizedException() : super('Permintaan memerlukan otentikasi pengguna, dan pengguna belum melakukan otentikasi atau otentikasinya gagal.');
}

class ForbiddenException extends HttpException {
  const ForbiddenException() : super('Server telah memahami permintaan, tetapi server menolak untuk mengizinkan akses ke sumber daya yang diminta.');
}

class NotFoundException extends HttpException {
  const NotFoundException() : super('Server tidak dapat menemukan sumber daya yang diminta.');
}

class InternalServerErrorException extends HttpException {
  const InternalServerErrorException() : super(' Server mengalami situasi yang tidak terduga yang menghalangi pemenuhan permintaan.');
}

class ServiceUnavailableException extends HttpException {
  const ServiceUnavailableException() : super('Server tidak siap untuk menangani permintaan. Layanan mungkin sementara tidak tersedia.');
}

class GatewayTimeoutException extends HttpException {
  const GatewayTimeoutException() : super('Server bertindak sebagai gateway atau proxy, tetapi tidak menerima tanggapan tepat waktu dari server upstream.');
}

class TooManyRequestsException extends HttpException {
  const TooManyRequestsException() : super('Pengguna telah melebihi batas tingkat permintaan yang diizinkan pada periode waktu tertentu.');
}

class TokenExpiredException extends HttpException {
  const TokenExpiredException() : super('Permintaan tidak dapat diotentikasi karena token yang digunakan telah kadaluarsa.');
}

class MissingParametersException extends HttpException {
  const MissingParametersException() : super(' Permintaan tidak dapat diproses karena parameter yang diperlukan tidak disediakan.');
}