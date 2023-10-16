part of 'detail_habbit_bloc.dart';

sealed class DetailHabbitState extends Equatable {
  const DetailHabbitState();

  @override
  List<Object> get props => [];
}

class HabbitDetailLoadedState extends DetailHabbitState {
  final String? error;

  const HabbitDetailLoadedState({this.error});
}

class HabbitDetailLoadingState extends DetailHabbitState {}

class HabbitDetailSuccesState extends DetailHabbitState {}

class HabbitResetState extends DetailHabbitState {}
