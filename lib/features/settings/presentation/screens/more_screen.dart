import 'package:ballaghny/config/routes/app_routes.dart';
import 'package:ballaghny/core/api/cache_helper.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/widgets/appbar/default_appbar.dart';
import 'package:ballaghny/core/widgets/default_button.dart';
import 'package:ballaghny/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:ballaghny/features/auth/presentation/cubits/delete_account/delete_account_cubit.dart';
import 'package:ballaghny/features/home/presentation/screens/home_screen.dart';
import 'package:ballaghny/features/islam/presentation/screens/orders_screen.dart';
import 'package:ballaghny/features/profile/presentation/screens/profile_screen.dart';
import 'package:ballaghny/features/contact_us/presentation/screens/contact_us_screen.dart';
import 'package:ballaghny/features/settings/presentation/screens/settings_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/core/widgets/bottom_sheets/default_bottom_sheet.dart';
import 'package:ballaghny/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ballaghny/features/settings/presentation/widgets/setting_item_widget.dart';
import 'package:ballaghny/features/splash/presentation/cubit/locale_cubit.dart';
import '../../../../injection_container.dart' as di;

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => di.sl<DeleteAccountCubit>(),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(gradient: AppColors.linearGradient),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DefaultAppBar(
                        title: AppLocalizations.of(context)!.translate('more')!,
                        onActionTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.notificationsRoute,
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      profileWidget(),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 7.5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SettingItemWidget(
                              onTap: () {
                                if (context
                                        .read<LoginCubit>()
                                        .authenticatedUser ==
                                    null) {
                                  showDefaultBottomSheet(
                                    context,
                                    title:
                                        AppLocalizations.of(
                                          context,
                                        )!.translate('must_login')!,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.translate('must_login')!,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DefaultButton(
                                                btnLbl:
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.translate('login')!,
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    Routes.loginRoute,
                                                  );
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: DefaultButton(
                                                isOutlined: true,
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                ),
                                                btnLbl:
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.translate('no')!,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrdersScreen(),
                                    ),
                                  );
                                }
                              },
                              backgroundIconColor: HexColor('#FCF0EA'),
                              title:
                                  AppLocalizations.of(
                                    context,
                                  )!.translate('my_orderes')!,
                              icon: Image.asset(AppAssets.ordersIcon),
                            ),
                            SettingItemWidget(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => HomeScreen(
                                          moreScreen: SettingsScreen(),
                                        ),
                                  ),
                                );
                              },
                              backgroundIconColor: HexColor('#E6F5FF'),
                              title:
                                  AppLocalizations.of(
                                    context,
                                  )!.translate('settings')!,
                              icon: Image.asset(AppAssets.settings),
                            ),
                            SettingItemWidget(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ContactUsScreen(),
                                  ),
                                );
                              },
                              backgroundIconColor: HexColor('#E8F5E9'),
                              title:
                                  AppLocalizations.of(
                                    context,
                                  )!.translate('call_us')!,
                              icon: Image.asset(AppAssets.callIcon),
                            ),
                            if (context.read<LoginCubit>().authenticatedUser !=
                                null)
                              // delete account
                              SettingItemWidget(
                                onTap: () {
                                  showDefaultBottomSheet(
                                    context,
                                    title:
                                        AppLocalizations.of(
                                          context,
                                        )!.translate('delete_your_account')!,
                                    child: BlocConsumer<
                                      DeleteAccountCubit,
                                      DeleteAccountState
                                    >(
                                      listener: (context, state) {
                                        if (state is DeleteAccountSuccess) {
                                          Navigator.pop(
                                            context,
                                          ); // إغلاق البوتوم شيت
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(state.message),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                          // تسجيل الخروج من التطبيق
                                          context
                                              .read<LoginCubit>()
                                              .logoutLocally(context: context);
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Routes.loginRoute,
                                            (route) => false,
                                          );
                                        } else if (state
                                            is DeleteAccountError) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(state.message),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                      builder: (context, state) {
                                        return Column(
                                          children: [
                                            Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.translate(
                                                'delete_account_confirmation',
                                              )!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: DefaultButton(
                                                    btnLbl:
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.translate('delete')!,
                                                    onPressed:
                                                        state is DeleteAccountLoading
                                                            ? () {}
                                                            : () {
                                                              context
                                                                  .read<
                                                                    DeleteAccountCubit
                                                                  >()
                                                                  .deleteAccount();
                                                            },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: DefaultButton(
                                                    isOutlined: true,
                                                    btnLbl:
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.translate('cancel')!,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                                title:
                                    AppLocalizations.of(
                                      context,
                                    )!.translate('delete_your_account')!,
                                backgroundIconColor: HexColor('#FFEBEE'),
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red.shade400,
                                ),
                              ),
                            if (context.read<LoginCubit>().authenticatedUser !=
                                null)
                              SettingItemWidget(
                                onTap: () {
                                  onLogoutTap(context);
                                },
                                isLast: true,
                                title:
                                    AppLocalizations.of(
                                      context,
                                    )!.translate('logout')!,
                                backgroundIconColor: HexColor('#FFEBEE'),
                                icon: Image.asset(AppAssets.ordersIcon),
                              ),

                            if (context.read<LoginCubit>().authenticatedUser ==
                                null)
                              SettingItemWidget(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.loginRoute,
                                  );
                                },
                                isLast: true,
                                title:
                                    AppLocalizations.of(
                                      context,
                                    )!.translate('login')!,
                                backgroundIconColor: HexColor('#FFEBEE'),
                                icon: Icon(Icons.login),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  profileWidget() {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (context.read<LoginCubit>().authenticatedUser == null) {
          return Container();
        }
        // log(context.read<LoginCubit>().authenticatedUser!.image!);
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            children: [
              CircleAvatar(
                // ignore: deprecated_member_use
                backgroundColor: Colors.grey.withOpacity(0.2),
                radius: 30,
                // backgroundImage: NetworkImage(
                //   context.read<LoginCubit>().authenticatedUser!.image!,

                // ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: CachedNetworkImage(
                    imageBuilder:
                        (context, imageProvider) => Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    imageUrl:
                        context.read<LoginCubit>().authenticatedUser!.image!,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget:
                        (context, url, error) =>
                            Image.asset(AppAssets.whiteImage),
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              // النصوص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.read<LoginCubit>().authenticatedUser!.name!,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      context.read<LoginCubit>().authenticatedUser!.email!,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // زر التعديل
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.translate('edit')!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

onLogoutTap(BuildContext context) {
  showDefaultBottomSheet(
    context,
    title: AppLocalizations.of(context)!.translate('logout')!,
    child: BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.translate('want_to_logout')!,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: DefaultButton(
                    btnLbl: AppLocalizations.of(context)!.translate('yes')!,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.loginRoute,
                        (route) => false,
                      );
                      CacheHelper.clearData();
                    },
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    isOutlined: true,
                    style: TextStyle(color: AppColors.primaryColor),
                    btnLbl: AppLocalizations.of(context)!.translate('no')!,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}
