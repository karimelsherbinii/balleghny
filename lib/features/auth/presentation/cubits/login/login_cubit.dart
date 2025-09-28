import 'dart:async';
import 'dart:developer';
import 'package:ballaghny/features/auth/domain/usecases/send_token.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/features/auth/data/models/user_model.dart';
import 'package:ballaghny/features/auth/domain/usecases/social_auth.dart';
import '../../../../../config/locale/app_localizations.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/api/base_response.dart';
import '../../../../../core/api/status_code.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../domain/usecases/get_saved_login_credentials.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/logout.dart';
import '../../../domain/usecases/logout_locally.dart';
import '../../../domain/usecases/save_login_credentials.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Login loginUseCase;
  final SocialAuth socialAuthUseCase;
  final GetSavedLoginCredentials getSavedLoginCredentialsUseCase;
  final SaveLoginCredentials saveLoginCredentials;
  final LogoutLoacally logoutLocallyUseCase;
  final Logout logoutUseCase;
  StreamSubscription? updateProfileSubscription;
  final SendToken sendTokenUseCase;

  LoginCubit({
    required this.loginUseCase,
    required this.getSavedLoginCredentialsUseCase,
    required this.saveLoginCredentials,
    required this.logoutLocallyUseCase,
    required this.logoutUseCase,
    required this.socialAuthUseCase,
    required this.sendTokenUseCase,
  }) : super(LoginInitial()) {
    // Initialize subscription if needed
    updateProfileSubscription = Stream.empty().listen((_) {});
  }

  bool isloading = false;
  UserModel? authenticatedUser;
  static LoginCubit get(context) => BlocProvider.of(context);

  void getSavedLoginCredentials() async {
    final response = await getSavedLoginCredentialsUseCase.call(NoParams());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (user) {
      if (user != null) {
        authenticatedUser = user as UserModel?;
        emit(Authenticated(authenticatedUser: authenticatedUser!));
      }
    });
  }

  Future<void> login({
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
    required String deviceType,
    required String firebaseToken,
    required bool credentialsIsSaved,
  }) async {
    if (formKey.currentState!.validate()) {
      changeLoadingView();
      Either<Failure, BaseResponse> response = await loginUseCase.call(
        LoginParams(
          email: email,
          password: password,
          deviceType: deviceType,
          firebaseToken: firebaseToken,
        ),
      );
      changeLoadingView();
      response.fold(
        (failure) => emit(UnAuthenticated(message: failure.message!)),
        (response) async {
          if (response.statusCode == StatusCode.ok && response.status == true) {
            authenticatedUser = response.data;
            if (credentialsIsSaved) {
              await saveLoginCredentials.call(
                SaveLoginCredentialsParams(user: authenticatedUser!),
              );
            }
            emit(Authenticated(authenticatedUser: authenticatedUser));
          } else {
            emit(
              UnAuthenticated(message: response.message ?? 'UnAuthenticated'),
            );
          }
        },
      );
    } else {
      emit(LoginValidatation(isValidate: true));
    }
  }

  @override
  Future<void> close() {
    updateProfileSubscription?.cancel();
    return super.close();
  }

  //social auth

  Future<void> socialAuth({
    required String provider,
    required String socialToken,
  }) async {
    changeLoadingView();
    Either<Failure, BaseResponse> response = await socialAuthUseCase.call(
      SocialAuthParams(provider: provider, socialToken: socialToken),
    );
    changeLoadingView();

    response.fold(
      (failure) => emit(UnAuthenticated(message: failure.message!)),
      (response) {
        if (response.statusCode == StatusCode.ok) {
          authenticatedUser = response.data;
          emit(Authenticated(authenticatedUser: authenticatedUser!));
        } else {
          emit(UnAuthenticated(message: response.message!));
        }
      },
    );
  }

  void changeLoadingView() {
    isloading = !isloading;
    emit(LoginLoading(isloading));
  }

  Future<void> logoutLocally({required BuildContext context}) async {
    Either<Failure, bool> response = await logoutLocallyUseCase.call(
      NoParams(),
    );
    response.fold(
      (falilure) => emit(UnAuthenticated(message: AppStrings.serverFailure)),
      (response) {
        emit(
          UnAuthenticated(
            message: AppLocalizations.of(context)!.translate('logout')!,
          ),
        );
        logoutLocallyUseCase.call(NoParams());
        authenticatedUser = null;
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.loginRoute,
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  Future<void> logoutFromServer({
    required BuildContext context,
    required firebaseToken,
  }) async {
    Either<Failure, BaseResponse> response = await logoutUseCase.call(
      LogoutParams(firebaseToken: firebaseToken),
    );
    response.fold(
      (falilure) =>
          emit(UnAuthenticatedFromServer(message: AppStrings.serverFailure)),
      (response) {
        emit(UnAuthenticatedFromServer(message: response.message!));
        logoutUseCase.call(LogoutParams(firebaseToken: firebaseToken));

        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.loginRoute,
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  Future<void> sendToken({
    required String token,
    required String deviceType,
  }) async {
    Either<Failure, BaseResponse> response = await sendTokenUseCase.call(
      SendTokenParams(token: token, deviceType: deviceType),
    );
    response.fold(
      (falilure) => emit(SendTokenFailed(message: AppStrings.serverFailure)),
      (response) {
        if (response.statusCode == StatusCode.ok) {
          log(response.message!, name: 'SendToken');
          emit(SendTokenSuccess(message: response.message!));
        } else {
          emit(SendTokenFailed(message: response.message!));
        }
      },
    );
  }
}
