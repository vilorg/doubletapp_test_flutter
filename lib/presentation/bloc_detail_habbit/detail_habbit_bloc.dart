import 'package:bloc/bloc.dart';
import 'package:doubletapp_habits/core/error/failure.dart';
import 'package:doubletapp_habits/data/models/habbit_model.dart';
import 'package:doubletapp_habits/domain/repository/repository.dart';
import 'package:doubletapp_habits/shared/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

part 'detail_habbit_event.dart';
part 'detail_habbit_state.dart';

class DetailHabbitBloc extends Bloc<DetailHabbitEvent, DetailHabbitState> {
  DetailHabbitBloc() : super(const HabbitDetailLoadedState()) {
    on<HabitDetailInitEvent>(
        (event, emit) => emit(const HabbitDetailLoadedState()));

    on<HabbitDetailSaveEvent>((event, emit) async {
      if (event.title.length < 3 || event.description.length < 3) {
        return emit(const HabbitDetailLoadedState(
            error: "Введите название и описание привычки!"));
      }
      if (event.count.isEmpty || event.frequency.isEmpty) {
        return emit(const HabbitDetailLoadedState(
            error: "Введите количество и периодичность привычки!"));
      } else if (int.tryParse(event.count) == null ||
          int.tryParse(event.frequency) == null) {
        return emit(const HabbitDetailLoadedState(
            error: "Введите количество и периодичность привычки цифрами!"));
      }
      HabbitModel habbit = HabbitModel(
        title: event.title,
        description: event.description,
        priority: event.priority,
        type: event.typeHabbit,
        count: int.parse(event.count),
        date: DateTime.now().difference(initDateTime).inSeconds,
        doneDates: [],
        frequency: int.parse(event.frequency),
        uid: event.uid,
      );
      Repository repository = GetIt.I.get<Repository>();
      (await repository.saveHabbit(habbit)).fold((l) {
        debugPrint(l.toString());
        if (l is ServerFailure) {
          emit(HabbitDetailLoadedState(error: l.message));
        }
      }, (r) => emit(HabbitDetailSuccesState()));
    });
  }
}
