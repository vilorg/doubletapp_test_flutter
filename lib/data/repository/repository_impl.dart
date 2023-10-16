import 'package:dartz/dartz.dart';
import 'package:doubletapp_habits/core/error/exception.dart';
import 'package:doubletapp_habits/core/error/failure.dart';
import 'package:doubletapp_habits/core/platform/network_info.dart';
import 'package:doubletapp_habits/data/datasources/local_data_source.dart';
import 'package:doubletapp_habits/data/datasources/remote_data_source.dart';
import 'package:doubletapp_habits/data/models/habbit_model.dart';
import 'package:doubletapp_habits/domain/repository/repository.dart';
import 'package:doubletapp_habits/shared/constants.dart';
import 'package:flutter/material.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<HabbitModel>>> getFirstHabbits() async {
    try {
      List<HabbitModel> habbits = await localDataSource.getLocalHabbits();
      if (habbits.isEmpty) {
        if (await networkInfo.isConnected) {
          List<HabbitModel> habbits = await remoteDataSource.getHabbits(token);
          await localDataSource.saveHabbitsToCache(habbits);
        } else {
          return right(habbits);
        }
      }
      return Right(habbits);
    } on ServerBadRequestException catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      debugPrint(e.toString());
      return const Left(ServerFailure(message: ""));
    }
  }

  @override
  Future<Either<Failure, List<HabbitModel>>> updateHabbits() async {
    try {
      List<HabbitModel> habbitsLocal = await localDataSource.getLocalHabbits();
      List<HabbitModel> habbitsRemote = [];
      if (await networkInfo.isConnected) {
        habbitsRemote = await remoteDataSource.getHabbits(token);
      } else {
        return right(habbitsLocal);
      }
      for (var habbit in habbitsLocal) {
        if (habbitsRemote.where((element) => element == habbit).isEmpty) {
          await remoteDataSource.saveHabbit(habbit, token);
        }
      }
      for (var habbit in habbitsRemote) {
        if (habbitsLocal
            .where((element) => element.uid == habbit.uid)
            .isEmpty) {
          await localDataSource.deleteHabbitsFromCache();
          await localDataSource.saveHabbitsToCache(habbitsRemote);
        }
      }
      return right(habbitsRemote);
    } on ServerBadRequestException catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      debugPrint(e.toString());
      return const Left(ServerFailure(message: ""));
    }
  }

  @override
  Future<Either<Failure, void>> saveHabbit(HabbitModel habbit) async {
    try {
      if (await networkInfo.isConnected) {
        String uid = await remoteDataSource.saveHabbit(habbit, token);

        if (habbit.uid != "") {
          List<HabbitModel> habbits = await localDataSource.getLocalHabbits();
          int index = habbits.indexOf(habbit);
          await localDataSource.deleteHabbitFromCache(index);
        }
        habbit = habbit.copyWith(uid: uid);
        await localDataSource.saveHabbitToCache(habbit);
      } else {
        await localDataSource.saveHabbitToCache(habbit);
      }
      return const Right(null);
    } on ServerBadRequestException catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      debugPrint(e.toString());
      return const Left(ServerFailure(message: ""));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHabbit(HabbitModel habbit) async {
    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.deleteHabbit(habbit.uid, token);
      }
      List<HabbitModel> habbits = await localDataSource.getLocalHabbits();
      int index = habbits.indexOf(habbit);
      localDataSource.deleteHabbitFromCache(index);
      return const Right(null);
    } on ServerBadRequestException catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      debugPrint(e.toString());
      return const Left(ServerFailure(message: ""));
    }
  }

  @override
  Future<Either<Failure, List<HabbitModel>>> doneHabbit(
      HabbitModel habbit) async {
    int secondsDate = DateTime.now().difference(initDateTime).inSeconds;
    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.doneHabbit(habbit.uid, secondsDate, token);
      }
      List<HabbitModel> habbits = await localDataSource.getLocalHabbits();
      int index = habbits.indexOf(habbit);
      localDataSource.deleteHabbitFromCache(index);

      List<int> doneDates = habbit.doneDates;
      doneDates.add(secondsDate);
      habbit = habbit.copyWith(doneDates: doneDates);
      await localDataSource.saveHabbitToCache(habbit);

      List<HabbitModel> newHabbits = await localDataSource.getLocalHabbits();
      return Right(newHabbits);
    } on ServerBadRequestException catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      debugPrint(e.toString());
      return const Left(ServerFailure(message: ""));
    }
  }
}
