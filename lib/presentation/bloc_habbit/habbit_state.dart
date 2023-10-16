part of 'habbit_bloc.dart';

sealed class HabbitState extends Equatable {
  const HabbitState();

  @override
  List<Object> get props => [];
}

class HabbitLoadingState extends HabbitState {}

class HabbitLoadedState extends HabbitState {
  final List<HabbitModel> habbits;
  final String? message;

  @override
  List<Object> get props => [habbits, message ?? ""];

  const HabbitLoadedState({required this.habbits, this.message});
}

class HabbitResetState extends HabbitState {}
