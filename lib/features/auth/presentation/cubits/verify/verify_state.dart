part of 'verify_cubit.dart';

abstract class VerifyState extends Equatable {
  const VerifyState();

  @override
  List<Object> get props => [];
}

class VerifyInitial extends VerifyState {}

class SendCodeLoadingState extends VerifyState {}

class SendCodeErrorState extends VerifyState {
  final String message;
  const SendCodeErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class SendCodeSuccessState extends VerifyState {
  final String message;
  const SendCodeSuccessState({required this.message});
  @override
  List<Object> get props => [message];
}

class VerifyLoadingState extends VerifyState {}

class VerifyEmailCodeErrorState extends VerifyState {
  final String message;
  const VerifyEmailCodeErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class VerifyEmailCodeSuccessState extends VerifyState {
  final String message;
  const VerifyEmailCodeSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}
