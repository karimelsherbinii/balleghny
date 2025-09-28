import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/features/islam/presentation/screens/introduction_to_islam_screen.dart';
import 'package:ballaghny/features/islam/presentation/screens/invitation_to_islam_screen.dart';
import 'package:ballaghny/features/settings/presentation/screens/more_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/features/bottom_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:ballaghny/features/bottom_navigation/presentation/screens/default_bottom_navigation.dart';
import 'package:ballaghny/features/home/presentation/screens/home_body.dart';

import '../../../../core/widgets/screen_container.dart';

class HomeScreen extends StatefulWidget {
  final Widget mainBody;
  final Widget travelerHubWidget;
  final Widget profileScreen;
  final Widget moreScreen;
  const HomeScreen({
    super.key,
    this.mainBody = const HomeBodyScreen(),
    this.travelerHubWidget = const InvitationToIslamScreen(),
    this.profileScreen = const IntroductionToIslamScreen(),
    this.moreScreen = const MoreScreen(),
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      widget.mainBody,
      widget.travelerHubWidget,
      widget.profileScreen,
      widget.moreScreen,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
      return ScreenContainer(
        key: const Key('home_screen'),
          child: WillPopScope(
        onWillPop: () async {
          if (BlocProvider.of<BottomNavigationCubit>(context)
              .navigationQueue
              .isEmpty) {
            return false;
          }
          BlocProvider.of<BottomNavigationCubit>(context).upadateBottomNavIndex(
              BlocProvider.of<BottomNavigationCubit>(context)
                  .navigationQueue
                  .last);
          BlocProvider.of<BottomNavigationCubit>(context)
              .navigationQueue
              .removeLast();
          return false;
        },
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Container(
                height: context.height,
                decoration: BoxDecoration(gradient: AppColors.linearGradient),
                child: Stack(
                  children: [
                    SafeArea(
                      child: _screens[context
                          .watch<BottomNavigationCubit>()
                          .bottomNavIndex],
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: DefaultBottomNavigation()),
                  ],
                ),
              ),
            ),
          ),
          // bottomNavigationBar: DefaultBottomNavigation(),
        ),
      ));
    });
  }
}
