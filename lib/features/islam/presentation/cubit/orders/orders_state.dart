part of 'orders_cubit.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {}


class GetOrdersLoadingState extends OrdersState {
  final bool isFirstFetch;
  const GetOrdersLoadingState({this.isFirstFetch = false});
  
  @override
  List<Object> get props => [isFirstFetch];
}

class GetOrdersSuccessState extends OrdersState {
  final List<OrderModel> message;
  const GetOrdersSuccessState({required this.message});
}

class GetOrdersErrorState extends OrdersState {
  final String message;
  const GetOrdersErrorState({required this.message});
}