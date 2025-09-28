part of 'statistics_cubit.dart';

abstract class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<Object> get props => [];
}

class StatisticsInitial extends StatisticsState {}

class StatisticsPeriodChanged extends StatisticsState {}

class GetStatisticsLoadingState extends StatisticsState {}

class GetStatisticsLoadedState extends StatisticsState {
  final DashboardModel statistics;

  const GetStatisticsLoadedState({required this.statistics});

  @override
  List<Object> get props => [statistics];
}

class GetStatisticsErrorState extends StatisticsState {
  final String message;

  const GetStatisticsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class GetChartStatisticsLoadingState extends StatisticsState {}

class GetChartStatisticsLoadedState extends StatisticsState {
  final StatisticModel statistics;

  const GetChartStatisticsLoadedState({required this.statistics});

  @override
  List<Object> get props => [statistics];
}

class GetChartStatisticsErrorState extends StatisticsState {
  final String message;

  const GetChartStatisticsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
