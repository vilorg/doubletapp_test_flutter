import 'package:dartz/dartz.dart';
import 'package:doubletapp_habits/core/error/failure.dart';
import 'package:doubletapp_habits/data/models/habbit_model.dart';

abstract class Repository {
  Future<Either<Failure, List<HabbitModel>>> getFirstHabbits();

  Future<Either<Failure, List<HabbitModel>>> updateHabbits();

  Future<Either<Failure, void>> saveHabbit(HabbitModel habbit);

  Future<Either<Failure, void>> deleteHabbit(HabbitModel habbit);

  Future<Either<Failure, List<HabbitModel>>> doneHabbit(HabbitModel habbit);
}
