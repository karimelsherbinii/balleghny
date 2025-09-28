import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/statistics/data/models/dashboard_model.dart';
import 'package:ballaghny/features/statistics/data/models/statistic_model.dart';
import 'package:ballaghny/features/statistics/domain/usecases/get_chart_statistics.dart';
import 'package:ballaghny/features/statistics/domain/usecases/get_statistics.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final GetStatistics getStatisticsUseCase;
  final GetChartStatistics getChartStatisticsUseCase;

  StatisticsCubit(
    this.getStatisticsUseCase,
    this.getChartStatisticsUseCase,
  ) : super(StatisticsInitial());

  String selectedPeriod = 'monthly';
  List<String> periods = ['monthly', 'yearly', 'weekly'];

  StatisticModel? statistics;

  void updateSelectedPeriod(String period) {
    emit(StatisticsInitial());
    selectedPeriod = period;
    emit(StatisticsPeriodChanged());
  }

  List<String> getTranslatedPeriods(BuildContext context) {
    return periods.map((period) {
      return AppLocalizations.of(context)!.translate(period) ?? 'monthly';
    }).toList();
  }

  DashboardModel? dashboardData;
  Future<void> getStatistics() async {
    emit(GetStatisticsLoadingState());
    final response = await getStatisticsUseCase.call(NoParams());
    response.fold(
      (failure) {
        emit(GetStatisticsErrorState(
            message: failure.message ?? 'Unknown Error'));
      },
      (data) {
        if (data.data != null && data.status == true) {
          dashboardData = data.data;
          emit(GetStatisticsLoadedState(statistics: data.data));
        } else {
          emit(GetStatisticsErrorState(
              message: data.message ?? 'Unknown Error'));
        }
      },
    );
  }

  Future<void> getChartStatistics() async {
    emit(GetChartStatisticsLoadingState());
    final response = await getChartStatisticsUseCase.call(NoParams());
    response.fold(
      (failure) {
        emit(GetChartStatisticsErrorState(
            message: failure.message ?? 'Unknown Error'));
      },
      (data) {
        statistics = data.data;
        emit(GetChartStatisticsLoadedState(statistics: data.data));
      },
    );
  }
}
