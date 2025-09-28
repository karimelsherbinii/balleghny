part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  final bool isloading;
  LoginLoading(this.isloading);
  @override
  List<Object> get props => [isloading];
}

class Authenticated extends LoginState {
  final UserModel? authenticatedUser;
  Authenticated({required this.authenticatedUser});
  @override
  List<Object?> get props => [authenticatedUser];
}

class UnAuthenticated extends LoginState {
  final String message;
  UnAuthenticated({required this.message});
  @override
  List<Object> get props => [message];
}

class UnAuthenticatedFromServer extends LoginState {
  final String message;
  UnAuthenticatedFromServer({required this.message});
  @override
  List<Object> get props => [message];
}

class LoginValidatation extends LoginState {
  final bool isValidate;
  LoginValidatation({required this.isValidate});
  @override
  List<Object> get props => [isValidate];
}

class SendTokenSuccess extends LoginState {
  final String message;
  SendTokenSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class SendTokenFailed extends LoginState {
  final String message;
  SendTokenFailed({required this.message});
  @override
  List<Object> get props => [message];
}
