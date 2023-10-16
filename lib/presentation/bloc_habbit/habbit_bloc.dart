import 'package:bloc/bloc.dart';
import 'package:doubletapp_habits/data/models/habbit_model.dart';
import 'package:doubletapp_habits/domain/repository/repository.dart';
import 'package:doubletapp_habits/shared/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

part 'habbit_event.dart';
part 'habbit_state.dart';

class HabbitBloc extends Bloc<HabbitEvent, HabbitState> {
  HabbitBloc() : super(HabbitLoadingState()) {
    on<HabbitInitEvent>((event, emit) async {
      Repository repository = GetIt.I.get<Repository>();
      (await repository.getFirstHabbits()).fold((l) {
        debugPrint(l.toString());
      }, (r) => emit(HabbitLoadedState(habbits: r)));
      (await repository.updateHabbits()).fold((l) {
        debugPrint(l.toString());
      }, (r) => emit(HabbitLoadedState(habbits: r)));
    });

    on<HabbitDeleteEvent>((event, emit) async {
      Repository repository = GetIt.I.get<Repository>();
      (await repository.deleteHabbit(event.habbit)).fold((l) {
        debugPrint(l.toString());
      }, (r) => emit(HabbitResetState()));
    });

    on<HabbitDoneEvent>((event, emit) async {
      Repository repository = GetIt.I.get<Repository>();
      (await repository.doneHabbit(event.habbit)).fold((l) {
        debugPrint(l.toString());
      }, (r) {
        String? text;
        int count = event.habbit.doneDates
            .where((int date) =>
                date >
                DateTime.now()
                    .add(-Duration(days: event.habbit.frequency))
                    .difference(initDateTime)
                    .inSeconds)
            .length;
        if (event.habbit.type == TypeHabbit.good) {
          if (count >= event.habbit.count) {
            text = "You are breathtaking!";
          } else {
            text = "Стоит выполнить еще ${event.habbit.count - count} раз";
          }
        } else {
          if (count >= event.habbit.count) {
            text = "Хватит это делать";
          } else {
            text = "Можете выполнить еще ${event.habbit.count - count} раз";
          }
        }
        emit(HabbitLoadedState(habbits: r));
        emit(HabbitLoadedState(habbits: r, message: text));
      });
    });
  }
}
