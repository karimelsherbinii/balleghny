part of 'reset_password_cubit.dart';

abstract class ResetPasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {
  final bool isloading;
  ResetPasswordLoading(this.isloading);
  @override
  List<Object> get props => [isloading];
}

class ResetPasswordSuccess extends ResetPasswordState {
  final String message;
  ResetPasswordSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class ResetPasswordFailed extends ResetPasswordState {
  final String message;
  ResetPasswordFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class ResetPasswordValidatation extends ResetPasswordState {
  final bool isValidate;
  ResetPasswordValidatation({required this.isValidate});
  @override
  List<Object> get props => [isValidate];
}

class VerifyPasswordCodeLoading extends ResetPasswordState {}

class VerifyPasswordCodeErrorState extends ResetPasswordState {
  final String message;
  VerifyPasswordCodeErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class VerifyPasswordCodeSuccessState extends ResetPasswordState {
  final String message;
  final String code;
  VerifyPasswordCodeSuccessState({required this.message, required this.code});

  @override
  List<Object> get props => [
        message,
        code,
      ];
}
