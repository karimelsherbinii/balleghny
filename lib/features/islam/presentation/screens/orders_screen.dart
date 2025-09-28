import 'dart:async';

import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/widgets/appbar/default_appbar.dart';
import 'package:ballaghny/core/widgets/bottom_sheets/default_bottom_sheet.dart';
import 'package:ballaghny/core/widgets/error_widget.dart';
import 'package:ballaghny/core/widgets/loading_indicator.dart';
import 'package:ballaghny/core/widgets/no_data.dart';
import 'package:ballaghny/features/islam/presentation/cubit/orders/orders_cubit.dart';
import 'package:ballaghny/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  //scroll controller
  final ScrollController _scrollController = ScrollController();

  void _setupScrollController(context) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0 &&
            BlocProvider.of<OrdersCubit>(context).pageNumber <=
                BlocProvider.of<OrdersCubit>(context).totalPages) {
          BlocProvider.of<OrdersCubit>(context).getOrders();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().getOrders();
    _setupScrollController(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(gradient: AppColors.linearGradient),
              child: Column(
                children: [
                  DefaultAppBar(
                    title:
                        AppLocalizations.of(context)!.translate('my_orderes')!,
                    onBackTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<OrdersCubit, OrdersState>(
                    builder: (context, state) {
                      if (state is GetOrdersLoadingState &&
                          state.isFirstFetch) {
                        return LoadingIndicator();
                      }
                      if (state is GetOrdersLoadingState) {
                        BlocProvider.of<OrdersCubit>(context).loadMore = true;
                      }
                      if (state is GetOrdersErrorState) {
                        return DefaultErrorWidget(msg: state.message);
                      }
                      if (state is GetOrdersSuccessState) {
                        if (BlocProvider.of<OrdersCubit>(
                          context,
                        ).orders.isEmpty) {
                          return NoData(
                            message:
                                AppLocalizations.of(
                                  context,
                                )!.translate('no_orders')!,
                          );
                        }
                      }

                      return Flexible(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              BlocProvider.of<OrdersCubit>(
                                context,
                              ).orders.length +
                              (BlocProvider.of<OrdersCubit>(context).loadMore
                                  ? 1
                                  : 0),
                          itemBuilder: (context, index) {
                            if (index <=
                                BlocProvider.of<OrdersCubit>(
                                      context,
                                    ).orders.length -
                                    1) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16.0),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(
                                    color: AppColors.borderColor,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '#${BlocProvider.of<OrdersCubit>(context).orders[index].firstName}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      '${AppLocalizations.of(context)!.translate('order_status')!}: ${BlocProvider.of<OrdersCubit>(context).orders[index].result ?? AppLocalizations.of(context)!.translate('new')!}',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '${AppLocalizations.of(context)!.translate('invited_status')!}: ${BlocProvider.of<OrdersCubit>(context).orders[index].status}',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      DateFormat.yMMMd(
                                        AppLocalizations.of(
                                          context,
                                        )!.locale.languageCode,
                                      ).format(
                                        DateTime.parse(
                                          BlocProvider.of<OrdersCubit>(context)
                                              .orders[index]
                                              .createdAt
                                              .replaceFirst(' am', '')
                                              .replaceFirst(' pm', ''),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (BlocProvider.of<OrdersCubit>(
                                  context,
                                ).pageNumber <=
                                BlocProvider.of<OrdersCubit>(
                                  context,
                                ).totalPages) {
                              Timer(const Duration(milliseconds: 30), () {
                                _scrollController.jumpTo(
                                  _scrollController.position.maxScrollExtent,
                                );
                              });
                              return LoadingIndicator();
                            }
                            return SizedBox(height: 100);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  onLangTap(BuildContext context) {
    showDefaultBottomSheet(
      context,
      title: AppLocalizations.of(context)!.translate('change_language')!,
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  context.read<LocaleCubit>().changeLang('en');
                },
                title: Text(
                  AppLocalizations.of(context)!.translate('english')!,
                ),
                leading: Radio(
                  value: 'en',
                  groupValue: context.read<LocaleCubit>().currentLangCode,
                  onChanged: (value) {
                    context.read<LocaleCubit>().changeLang(value as String);
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                onTap: () {
                  context.read<LocaleCubit>().changeLang('ar');
                },
                title: Text(AppLocalizations.of(context)!.translate('arabic')!),
                leading: Radio(
                  value: 'ar',
                  groupValue: context.read<LocaleCubit>().currentLangCode,
                  onChanged: (value) {
                    context.read<LocaleCubit>().changeLang(value as String);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget notificationSwitchButton({
    bool isNotificationsEnabled = false,
    Function()? onTapSwitch,
  }) {
    return InkWell(
      onTap: onTapSwitch,
      child: Transform(
        //make switch scale = 0.7
        transform: Matrix4.identity()..scale(0.7),
        child: Switch(
          value: isNotificationsEnabled,
          activeColor: AppColors.primaryColor,
          inactiveThumbColor: AppColors.primaryColor,
          onChanged: (value) {
            onTapSwitch!();
          },
        ),
      ),
    );
  }
}
