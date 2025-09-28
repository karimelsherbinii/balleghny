// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/core/widgets/loading_indicator.dart';
import 'package:ballaghny/features/statistics/data/models/statistic_model.dart';
import 'package:ballaghny/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeChartWidget extends StatelessWidget {
  const HomeChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state is GetChartStatisticsLoadingState) {
          return const LoadingIndicator();
        }

        final statsCubit = context.read<StatisticsCubit>();
        final periods = statsCubit.getTranslatedPeriods(context);
        final selectedPeriod = statsCubit.selectedPeriod;
        final translatedSelectedPeriod =
            AppLocalizations.of(context)!.translate(selectedPeriod)!;

        StatisticModel? currentStatistic;
        if (statsCubit.statistics != null) {
          currentStatistic = statsCubit.statistics!;
        }

        log('Current statistic: $currentStatistic');

        // احسب بيانات الأعمدة مرة واحدة
        final barGroups = _generateBarGroups(
          context,
          currentStatistic,
          selectedPeriod,
        );

        return Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            border: Border.all(color: HexColor('ECF0F3')),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header row with title and dropdown
              Row(
                children: [
                  Text(
                    AppLocalizations.of(
                      context,
                    )!.translate('total_statistics')!,
                    style: TextStyle(
                      color: HexColor('05030D'),
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: HexColor('#F0F6EC'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButton<String>(
                      value: translatedSelectedPeriod,
                      icon: Image.asset(AppAssets.dropDownIcon),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.transparent,
                      ),
                      onChanged: (String? newValue) {
                        final untranslatedPeriod = statsCubit.periods
                            .firstWhere(
                              (period) =>
                                  AppLocalizations.of(
                                    context,
                                  )!.translate(period) ==
                                  newValue,
                            );
                        statsCubit.updateSelectedPeriod(untranslatedPeriod);
                      },
                      items:
                          periods.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Chart section
              SizedBox(
                height: 300, // Fixed height for the chart
                child: BarChart(
                  BarChartData(
                    minY: 0,
                    maxY: _calculateMaxY(barGroups),
                    barGroups: barGroups,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return _buildTitles(
                              context,
                              value.toInt(),
                              selectedPeriod,
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: _calculateHorizontalInterval(
                        _calculateMaxY(barGroups),
                      ),
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey.withOpacity(0.15),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    barTouchData: BarTouchData(enabled: true),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // دالة لحساب أعلى قيمة y ديناميكية
  double _calculateMaxY(List<BarChartGroupData> barGroups) {
    if (barGroups.isEmpty) return 10; // قيمة افتراضية لو مفيش بيانات
    final maxY = barGroups
        .map((group) => group.barRods.first.toY)
        .reduce((a, b) => a > b ? a : b);
    // زود 10% أو رقم ثابت
    return (maxY * 1.1).ceilToDouble();
  }

  // دالة لحساب interval المناسب للخطوط الأفقية
  double _calculateHorizontalInterval(double maxY) {
    if (maxY <= 0) return 1;
    return (maxY / 6).ceilToDouble();
  }

  // تحضير بيانات الرسم بناءً على الـ StatisticModel والفترة المختارة
  List<BarChartGroupData> _generateBarGroups(
    BuildContext context,
    StatisticModel? statistic,
    String period,
  ) {
    if (statistic == null) return [];

    switch (period) {
      case 'weekly':
        if (statistic.weekly == null) return [];
        return [
          _buildBarGroup(0, statistic.weekly!.sunday.toDouble()),
          _buildBarGroup(1, statistic.weekly!.monday.toDouble()),
          _buildBarGroup(2, statistic.weekly!.tuesday.toDouble()),
          _buildBarGroup(3, statistic.weekly!.wednesday.toDouble()),
          _buildBarGroup(4, statistic.weekly!.thursday.toDouble()),
          _buildBarGroup(5, statistic.weekly!.friday.toDouble()),
          _buildBarGroup(6, statistic.weekly!.saturday.toDouble()),
        ];
      case 'monthly':
        if (statistic.monthly == null) return [];
        return [
          _buildBarGroup(0, statistic.monthly!.week1.toDouble()),
          _buildBarGroup(1, statistic.monthly!.week2.toDouble()),
          _buildBarGroup(2, statistic.monthly!.week3.toDouble()),
          _buildBarGroup(3, statistic.monthly!.week4.toDouble()),
        ];
      case 'yearly':
        if (statistic.yearly == null) return [];
        return [
          _buildBarGroup(0, statistic.yearly!.jan.toDouble()),
          _buildBarGroup(1, statistic.yearly!.feb.toDouble()),
          _buildBarGroup(2, statistic.yearly!.mar.toDouble()),
          _buildBarGroup(3, statistic.yearly!.apr.toDouble()),
          _buildBarGroup(
            4,
            statistic.yearly!.may == null
                ? 0
                : statistic.yearly!.may!.toDouble(),
          ),
          _buildBarGroup(5, statistic.yearly!.jun.toDouble()),
          _buildBarGroup(6, statistic.yearly!.jul.toDouble()),
          _buildBarGroup(7, statistic.yearly!.aug.toDouble()),
          _buildBarGroup(8, statistic.yearly!.sep.toDouble()),
          _buildBarGroup(9, statistic.yearly!.oct.toDouble()),
          _buildBarGroup(10, statistic.yearly!.nov.toDouble()),
          _buildBarGroup(11, statistic.yearly!.dec.toDouble()),
        ];
      // في حالة (daily) أو غيره، أضف حالة أخرى أو ارجع قائمة فارغة
      default:
        return [];
    }
  }

  BarChartGroupData _buildBarGroup(int x, double y) {
    // إذا كانت القيمة صفر، اجعل العمود بارتفاع بسيط جداً
    final adjustedY = (y == 0) ? 0.05 : y;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: adjustedY,
          gradient: LinearGradient(
            colors: [
              HexColor('509425').withOpacity(0.9),
              HexColor('DCE7D5').withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          width: 25,
          borderRadius: BorderRadius.circular(8),
        ),
      ],
    );
  }

  // بناء عناوين المحور السفلي بناءً على الفترة
  Widget _buildTitles(BuildContext context, int index, String period) {
    final translator = AppLocalizations.of(context)!;
    switch (period) {
      case 'weekly':
        // تعيين العناوين لأيام الأسبوع
        switch (index) {
          case 0:
            return ChartTitleWidget(title: translator.translate('sunday')!);
          case 1:
            return ChartTitleWidget(title: translator.translate('monday')!);
          case 2:
            return ChartTitleWidget(title: translator.translate('tuesday')!);
          case 3:
            return ChartTitleWidget(title: translator.translate('wednesday')!);
          case 4:
            return ChartTitleWidget(title: translator.translate('thursday')!);
          case 5:
            return ChartTitleWidget(title: translator.translate('friday')!);
          case 6:
            return ChartTitleWidget(title: translator.translate('saturday')!);
          default:
            return const SizedBox.shrink();
        }
      case 'monthly':
        // تعيين العناوين لأسابيع الشهر
        switch (index) {
          case 0:
            return ChartTitleWidget(
              title: translator.translate('week_1') ?? 'Week 1',
            );
          case 1:
            return ChartTitleWidget(
              title: translator.translate('week_2') ?? 'Week 2',
            );
          case 2:
            return ChartTitleWidget(
              title: translator.translate('week_3') ?? 'Week 3',
            );
          case 3:
            return ChartTitleWidget(
              title: translator.translate('week_4') ?? 'Week 4',
            );
          default:
            return const SizedBox.shrink();
        }
      case 'yearly':
        // تعيين العناوين لشهور السنة
        switch (index) {
          case 0:
            return ChartTitleWidget(title: translator.translate('jan')!);
          case 1:
            return ChartTitleWidget(title: translator.translate('feb')!);
          case 2:
            return ChartTitleWidget(title: translator.translate('mar')!);
          case 3:
            return ChartTitleWidget(title: translator.translate('apr')!);
          case 4:
            return ChartTitleWidget(title: translator.translate('may')!);
          case 5:
            return ChartTitleWidget(title: translator.translate('jun')!);
          case 6:
            return ChartTitleWidget(title: translator.translate('jul')!);
          case 7:
            return ChartTitleWidget(title: translator.translate('aug')!);
          case 8:
            return ChartTitleWidget(title: translator.translate('sep')!);
          case 9:
            return ChartTitleWidget(title: translator.translate('oct')!);
          case 10:
            return ChartTitleWidget(title: translator.translate('nov')!);
          case 11:
            return ChartTitleWidget(title: translator.translate('dec')!);
          default:
            return const SizedBox.shrink();
        }
      default:
        return const SizedBox.shrink();
    }
  }
}

class ChartTitleWidget extends StatelessWidget {
  final String title;
  const ChartTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: HexColor('05030D'),
        fontSize: context.width * 0.02,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
