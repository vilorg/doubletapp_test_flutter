part of 'detail_habbit_bloc.dart';

sealed class DetailHabbitEvent extends Equatable {
  const DetailHabbitEvent();

  @override
  List<Object> get props => [];
}

class HabitDetailInitEvent extends DetailHabbitEvent {}

class HabbitDetailSaveEvent extends DetailHabbitEvent {
  final String title;
  final String description;
  final TypeHabbit typeHabbit;
  final Priorety priority;
  final String count;
  final String frequency;
  final String uid;

  const HabbitDetailSaveEvent(
    this.title,
    this.description,
    this.typeHabbit,
    this.priority,
    this.count,
    this.frequency,
    this.uid,
  );

  @override
  List<Object> get props => [
        title,
        description,
        typeHabbit,
        priority,
        count,
        frequency,
        uid,
      ];
}
