
class ServerException implements Exception{
  final String message;
  ServerException(this.message);
}
class BadRequestException implements Exception{
  final String message;
  BadRequestException(this.message);
}
class CacheException implements Exception{
  final String message;
  CacheException(this.message);
}
class OfflineException implements Exception{
  final String message;
  OfflineException(this.message);
}
class UnauthorizedException implements Exception{
  final String message;
  UnauthorizedException(this.message);
}
class NotFoundException implements Exception{
  final String message;
  NotFoundException(this.message);
}
class InvalidInputException implements Exception{
  final String message;
  InvalidInputException(this.message);
}