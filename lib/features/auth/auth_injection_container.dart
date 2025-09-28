import 'package:ballaghny/features/auth/domain/usecases/send_code.dart';
import 'package:ballaghny/features/auth/domain/usecases/send_token.dart';
import 'package:ballaghny/features/auth/domain/usecases/social_auth.dart';
import 'package:ballaghny/features/auth/domain/usecases/verify_email_code.dart';
import 'package:ballaghny/features/auth/domain/usecases/verify_password_code.dart';
import 'package:ballaghny/features/auth/domain/usecases/delete_account.dart';
import 'package:ballaghny/features/auth/presentation/cubits/verify/verify_cubit.dart';
import 'package:ballaghny/features/auth/presentation/cubits/delete_account/delete_account_cubit.dart';

import 'data/datasources/auth_local_data_source.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/get_saved_login_credentials.dart';
import 'domain/usecases/logout.dart';
import 'domain/usecases/logout_locally.dart';
import 'domain/usecases/register.dart';
import 'domain/usecases/reset_password.dart';
import 'domain/usecases/save_login_credentials.dart';
import 'presentation/cubits/login/login_cubit.dart';
import 'presentation/cubits/register/register_cubit.dart';
import 'presentation/cubits/reset_password/reset_password_cubit.dart';
import '../../injection_container.dart';
import 'domain/usecases/login.dart';

void initAuthFeature() {
  // Blocs
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      getSavedLoginCredentialsUseCase: sl(),
      loginUseCase: sl(),
      logoutLocallyUseCase: sl(),
      logoutUseCase: sl(),
      saveLoginCredentials: sl(),
      socialAuthUseCase: sl(),
      sendTokenUseCase: sl(),
    ),
  );

  sl.registerFactory<RegisterCubit>(
    () => RegisterCubit(registerUseCase: sl(), saveLoginCredentials: sl()),
  );

  sl.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(
      resetPasswordUseCase: sl(),
      verifyPasswordCodeUseCase: sl(),
    ),
  );
  sl.registerFactory<VerifyCubit>(
    () => VerifyCubit(sendCodeUseCase: sl(), verifyEmailCodeUseCase: sl()),
  );

  sl.registerFactory<DeleteAccountCubit>(
    () => DeleteAccountCubit(deleteAccountUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton<Login>(() => Login(authRepository: sl()));
  sl.registerLazySingleton<SendToken>(() => SendToken(sl()));
  sl.registerLazySingleton<Register>(() => Register(authRepository: sl()));
  sl.registerLazySingleton<ResetPassword>(
    () => ResetPassword(authRepository: sl()),
  );
  sl.registerLazySingleton<GetSavedLoginCredentials>(
    () => GetSavedLoginCredentials(authRepository: sl()),
  );
  sl.registerLazySingleton<SaveLoginCredentials>(
    () => SaveLoginCredentials(authRepository: sl()),
  );
  sl.registerLazySingleton<LogoutLoacally>(
    () => LogoutLoacally(authRepository: sl()),
  );
  sl.registerLazySingleton<Logout>(() => Logout(authRepository: sl()));
  sl.registerLazySingleton<SocialAuth>(() => SocialAuth(authRepository: sl()));
  sl.registerLazySingleton<SendCode>(() => SendCode(authRepository: sl()));
  sl.registerLazySingleton<VerifyEmailCode>(
    () => VerifyEmailCode(authRepository: sl()),
  );
  sl.registerLazySingleton<VerifyPasswordCode>(
    () => VerifyPasswordCode(authRepository: sl()),
  );
  sl.registerLazySingleton<DeleteAccount>(
    () => DeleteAccount(repository: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authLocalDataSource: sl(),
      authRemoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );
}
