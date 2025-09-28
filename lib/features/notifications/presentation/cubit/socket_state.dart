part of 'socket_cubit.dart';

abstract class SocketState extends Equatable {
  const SocketState();

  @override
  List<Object> get props => [];
}

class SocketInitial extends SocketState {}
