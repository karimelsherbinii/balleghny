part of 'de_active_cubit.dart';

abstract class DeActiveState extends Equatable {
  const DeActiveState();

  @override
  List<Object> get props => [];
}

class DeActiveInitial extends DeActiveState {}

class DeActiveLoading extends DeActiveState {}

class DeActiveSuccess extends DeActiveState {
  final String message;

  const DeActiveSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class DeActiveError extends DeActiveState {
  final String message;

  const DeActiveError({required this.message});

  @override
  List<Object> get props => [message];
}
