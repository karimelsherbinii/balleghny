part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {
  final bool isloading;
  RegisterLoading(this.isloading);
  @override
  List<Object> get props => [isloading];
}

class RegisterSuccess extends RegisterState {
  final UserModel user;
  final String message;
  RegisterSuccess({required this.user, required this.message});
  @override
  List<Object> get props => [user, message];
}

class RegisterFailed extends RegisterState {
  final String message;
  RegisterFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class RegisterValidatation extends RegisterState {
  final bool isValidate;
  RegisterValidatation({required this.isValidate});
  @override
  List<Object> get props => [isValidate];
}
