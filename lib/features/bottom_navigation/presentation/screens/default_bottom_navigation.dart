import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/features/bottom_navigation/presentation/cubit/bottom_navigation_cubit.dart';

class DefaultBottomNavigation extends StatefulWidget {
  const DefaultBottomNavigation({super.key});

  @override
  State<DefaultBottomNavigation> createState() =>
      _DefaultBottomNavigationState();
}

class _DefaultBottomNavigationState extends State<DefaultBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
      return Container(
        margin: EdgeInsets.all(16), // Add margin
        padding: EdgeInsets.all(10), // Add padding
        decoration: BoxDecoration(
          color: HexColor('#101828'),
          borderRadius: BorderRadius.circular(50), // Add radius
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), // Add radius
          child: BottomNavigationBar(
            backgroundColor: HexColor('#101828'),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.home,
                  color: Colors.white,
                  // height: 30,
                ),
                label: AppLocalizations.of(context)!.translate('home'),
                activeIcon: Image.asset(
                  AppAssets.home,
                  // height: 30,
                  color: AppColors.secondryColor,
                ),
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.mailPerson,
                  color: Colors.white,
                  // height: 30,
                ),
                label: AppLocalizations.of(context)!.translate('invite')!,
                activeIcon: Image.asset(
                  AppAssets.mailPerson,
                  // height: 30,
                  color: AppColors.secondryColor,
                ),
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.islamIcon,
                  // height: 30,
                  color: Colors.white,
                ),
                label: AppLocalizations.of(context)!
                    .translate('islam'),
                activeIcon: Image.asset(
                  AppAssets.islamIcon,
                  // height: 30,
                  color: AppColors.secondryColor,
                ),
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
                label: AppLocalizations.of(context)!.translate('more'),
                activeIcon: Icon(
                  Icons.more_horiz,
                  color: AppColors.secondryColor,
                ),
                backgroundColor: Colors.white,
              ),
            ],
            selectedItemColor: AppColors.secondryColor,
            unselectedItemColor: Colors.white,
            selectedLabelStyle: TextStyle(
                color: AppColors.secondryColor,
                fontSize: 10,
                fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(
                overflow: TextOverflow.visible,
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w400),
            type: BottomNavigationBarType.fixed,

            currentIndex: context.watch<BottomNavigationCubit>().bottomNavIndex,
            onTap: (index) {
              BlocProvider.of<BottomNavigationCubit>(context)
                  .navigationQueue
                  .addLast(BlocProvider.of<BottomNavigationCubit>(context)
                      .bottomNavIndex);
              BlocProvider.of<BottomNavigationCubit>(context)
                  .upadateBottomNavIndex(index);
            },
            elevation: 0, // Remove default elevation
          ),
        ),
      );
    });
  }
}
