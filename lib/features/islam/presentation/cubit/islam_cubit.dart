import 'dart:convert';
import 'dart:developer';

import 'package:ballaghny/core/models/country.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/core/utils/app_strings.dart';
import 'package:ballaghny/features/auth/data/models/user_model.dart';
import 'package:ballaghny/features/islam/data/models/difination/definitio_model.dart';
import 'package:ballaghny/features/islam/data/models/order_model.dart';
import 'package:ballaghny/features/islam/domain/usecases/get_introductions.dart';
import 'package:ballaghny/features/islam/domain/usecases/get_orders.dart';
import 'package:ballaghny/features/islam/domain/usecases/invite_to_islam.dart';
import 'package:ballaghny/features/islam/domain/usecases/share_definition.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'islam_state.dart';

class IslamCubit extends Cubit<IslamState> {
  final GetIntroductions getIntroductionsUseCase;
  final InviteToIslam inviteToIslamUseCase;
  final ShareDefinition shareDefinitionUseCase;
  IslamCubit(
    this.getIntroductionsUseCase,
    this.inviteToIslamUseCase,
    this.shareDefinitionUseCase,
  ) : super(IslamInitial());

  List<DefinitionModel> definitions = [];

  bool loadMore = false;
  int totalPages = 1;
  int pageNumber = 1;

  Future<void> getIntroductions({String? search}) async {
    emit(GetIntroductionsLoadingState());
    final response = await getIntroductionsUseCase.call(
      GetIntroductionsParams(search: search ?? ''),
    );
    response.fold(
      (failure) => emit(GetIntroductionsErrorState(message: failure.message!)),
      (response) {
        definitions = response.data!;
        emit(GetIntroductionsSuccessState(message: response.message ?? ''));
      },
    );
  }

  Future<void> inviteToIslam({
    required String name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? country,
    String? city,
    String? language,
    String? religion,
    String? socialMediaAccount,
  }) async {
    emit(InviteToIslamLoadingState());
    final response = await inviteToIslamUseCase.call(
      InviteToIslamParams(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        gender: gender,
        country: country,
        city: city,
        language: language,
        religion: religion,
        socialMediaAccount: socialMediaAccount,
      ),
    );
    response.fold(
      (failure) => emit(InviteToIslamErrorState(message: failure.message!)),
      (response) => emit(
        InviteToIslamSuccessState(
          message: response.message ?? 'Success Invite To Islam',
        ),
      ),
    );
  }

  // List<DefinitionModel> searchResults = [];
  // searchInDefinitions(String search) {
  //   emit(IslamInitial());
  //   searchResults = definitions
  //       .where((element) =>
  //           element.title!.toLowerCase().contains(search.toLowerCase()))
  //       .toList();
  //   definitions = searchResults;
  //   emit(SearchInDefinitionsState(definitions: searchResults));
  // }

  Future<void> shareDefinition(int id) async {
    emit(ShareDefinitionLoadingState());
    final response = await shareDefinitionUseCase.call(
      ShareDefinitionParams(id: id),
    );
    response.fold(
      (failure) => emit(ShareDefinitionErrorState(message: failure.message!)),
      (response) =>
          emit(ShareDefinitionSuccessState(message: response.message ?? '')),
    );
  }
}
