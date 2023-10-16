part of 'habbit_bloc.dart';

sealed class HabbitEvent extends Equatable {
  const HabbitEvent();

  @override
  List<Object> get props => [];
}

class HabbitInitEvent extends HabbitEvent {}

class HabbitDeleteEvent extends HabbitEvent {
  final HabbitModel habbit;

  const HabbitDeleteEvent({required this.habbit});
}

class HabbitDoneEvent extends HabbitEvent {
  final HabbitModel habbit;

  const HabbitDoneEvent({required this.habbit});

  @override
  List<Object> get props => [habbit];
}
