import 'package:ballaghny/features/islam/data/models/order_model.dart';
import 'package:ballaghny/features/islam/domain/usecases/get_orders.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrders GetOrdersUseCase;

  OrdersCubit(this.GetOrdersUseCase) : super(OrdersInitial());
  List<OrderModel> orders = [];
  int pageNumber = 1;
  int totalPages = 1;
  bool loadMore = false;
  Future<void> getOrders() async {
    if (state is GetOrdersLoadingState) return;
    emit(GetOrdersLoadingState(isFirstFetch: pageNumber == 1));
    final response = await GetOrdersUseCase.call(
      GetOrdersParams(page: pageNumber),
    );
    response.fold(
      (failure) => emit(GetOrdersErrorState(message: failure.message!)),
      (response) {
        orders.addAll(response.data!);
        totalPages = response.lastPage ?? 1;
        pageNumber++;
        emit(GetOrdersSuccessState(message: response.data));
      },
    );
  }
}
