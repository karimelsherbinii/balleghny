import 'dart:developer';

import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/core/widgets/appbar/default_appbar.dart';
import 'package:ballaghny/core/widgets/error_widget.dart';
import 'package:ballaghny/core/widgets/loading_indicator.dart';
import 'package:ballaghny/core/widgets/must_login_screen.dart';
import 'package:ballaghny/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:ballaghny/features/bottom_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:ballaghny/features/home/presentation/widgets/home_chart.dart';
import 'package:ballaghny/features/statistics/data/models/statistic_model.dart';
import 'package:ballaghny/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/config/routes/app_routes.dart';
import 'package:ballaghny/core/api/cache_helper.dart';
import 'package:ballaghny/core/utils/app_strings.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/locale/app_localizations.dart';

class HomeBodyScreen extends StatefulWidget {
  const HomeBodyScreen({super.key});

  @override
  State<HomeBodyScreen> createState() => _HomeBodyScreenState();
}

class _HomeBodyScreenState extends State<HomeBodyScreen> {
  String? selectedLocation;
  _getLocationIsSelected() async {
    selectedLocation = await CacheHelper.getData(
      key: AppStrings.currentLocation,
    );
  }

  _getStatistics() async {
    if (!mounted) return;
    await context.read<StatisticsCubit>().getStatistics().then((v) {
      if (mounted) {
        _getChartStatistics();
      }
    });
  }

  Future _getChartStatistics() async {
    if (!mounted) return;
    await context.read<StatisticsCubit>().getChartStatistics();
  }

  @override
  void initState() {
    super.initState();
    _getLocationIsSelected();
    context.read<BottomNavigationCubit>().upadateBottomNavIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    var translator = AppLocalizations.of(context)!;
    log(
      context.read<LoginCubit>().authenticatedUser.toString(),
      name: 'authenticatedUser',
    );
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (context.read<LoginCubit>().authenticatedUser == null) {
          return MustLoginScreen(
            message: translator.translate('login_to_see_dashboard')!,
          );
        }

        // Move statistics fetching to a more appropriate place
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted &&
              (selectedLocation != null ||
                  context.read<LoginCubit>().authenticatedUser != null)) {
            _getStatistics();
          }
        });
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.homeBg),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultAppBar(
                  title: AppLocalizations.of(context)!.translate('home')!,
                  showBackButton: false,
                  onBackTap: () {
                    Constants.showExitDialog(context);
                  },
                  onActionTap: () {
                    Navigator.pushNamed(context, Routes.notificationsRoute);
                  },
                ),
                SizedBox(height: 20),
                buildDashboard(translator),
                const SizedBox(height: 16),
                SizedBox(
                  height: 400, // Set a fixed height for the chart
                  child: HomeChartWidget(),
                ),
                SizedBox(height: context.height * 0.1),
              ],
            ),
          ),
        );
      },
    );
  }

  buildDashboard(AppLocalizations translator) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state is GetStatisticsLoadingState) {
          return LoadingIndicator();
        } else if (state is GetStatisticsErrorState) {
          return DefaultErrorWidget(msg: state.message);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: HexColor('ECF0F3')),
              borderRadius: BorderRadius.circular(8),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 3,
              children: [
                if (context.read<StatisticsCubit>().dashboardData == null)
                  Text(translator.translate('no_data_found')!)
                else ...[
                  HomeAnalyticsWidget(
                    name: translator.translate('total')!,
                    value:
                        context
                            .read<StatisticsCubit>()
                            .dashboardData!
                            .total
                            .toString(),
                  ),
                  HomeAnalyticsWidget(
                    name: translator.translate('new_requests')!,
                    value:
                        context
                            .read<StatisticsCubit>()
                            .dashboardData!
                            .newCases
                            .toString(),
                  ),
                  HomeAnalyticsWidget(
                    name: translator.translate('open_requests')!,
                    value:
                        context
                            .read<StatisticsCubit>()
                            .dashboardData!
                            .inProgress
                            .toString(),
                  ),
                  HomeAnalyticsWidget(
                    name: translator.translate('closed_requests')!,
                    value:
                        context
                            .read<StatisticsCubit>()
                            .dashboardData!
                            .closed
                            .toString(),
                  ),
                  HomeAnalyticsWidget(
                    name: translator.translate('islamed_requests')!,
                    value:
                        context
                            .read<StatisticsCubit>()
                            .dashboardData!
                            .muslims
                            .toString(),
                  ),
                  HomeAnalyticsWidget(
                    name: translator.translate('not_iaslamed_requests')!,
                    value:
                        context
                            .read<StatisticsCubit>()
                            .dashboardData!
                            .nonMuslims
                            .toString(),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeAnalyticsWidget extends StatelessWidget {
  final String name;
  final String value;
  const HomeAnalyticsWidget({
    super.key,
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: HexColor('ECF0F3')),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
