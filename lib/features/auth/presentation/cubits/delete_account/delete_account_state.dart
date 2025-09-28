part of 'delete_account_cubit.dart';

abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountSuccess extends DeleteAccountState {
  final String message;

  const DeleteAccountSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteAccountError extends DeleteAccountState {
  final String message;

  const DeleteAccountError({required this.message});

  @override
  List<Object> get props => [message];
}
