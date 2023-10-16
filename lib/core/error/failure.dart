// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class ServerFailure extends Failure {
  final String message;

  const ServerFailure({required this.message});
}

class ServerUnauthFailure extends ServerFailure {
  const ServerUnauthFailure({required super.message});
}

class CacheFailure extends Failure {}

class ConnectionFailure extends Failure {}
