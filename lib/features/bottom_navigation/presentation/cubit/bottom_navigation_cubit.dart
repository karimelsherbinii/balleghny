import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationInitial());

  int bottomNavIndex = 0;
  int homeTabIndex = 0;
  bool comingFromProfile = false;
  ListQueue<int> navigationQueue = ListQueue();
  void upadateBottomNavIndex(int value) {
    emit(BottomNavigationInitial());
    bottomNavIndex = value;
    emit(BottomNavIsChanging());
  }

  void updateHomeTabIndex(int tabIndex,
      {bool comingFromProfileScreen = false}) {
    homeTabIndex = tabIndex;
    comingFromProfile = comingFromProfileScreen;
  }
}
