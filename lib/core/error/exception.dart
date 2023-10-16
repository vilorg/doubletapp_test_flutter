class ServerException implements Exception {}

class ServerBadRequestException extends ServerException {
  final String message;

  ServerBadRequestException({required this.message});
}

class ServerUnauthException extends ServerException {}

class CacheException implements Exception {}
