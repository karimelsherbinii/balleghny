import 'package:ballaghny/features/terms_and_conditions/presentation/cubit/terms_and_conditions_cubit.dart';
import 'package:ballaghny/features/terms_and_conditions/data/datasources/terms_and_conditions_remote_data_source.dart';
import 'package:ballaghny/features/terms_and_conditions/domain/repositories/terms_and_conditions_repository.dart';
import '../../injection_container.dart';
import 'data/repositories/terms_and_conditions_repository_impl.dart';
import 'domain/usecases/get_terms_and_conditions.dart';

void initTermsAndConditionsFeature() {
// Blocs
  sl.registerFactory<TermsAndConditionsCubit>(
      () => TermsAndConditionsCubit(useCase: sl()));

  // Use cases
  sl.registerLazySingleton<GetTermsAndConditions>(
      () => GetTermsAndConditions(termsAndConditionsRepository: sl()));

  // Repository
  sl.registerLazySingleton<TermsAndConditionsRepository>(() =>
      TermsAndConditionsRepositoryImpl(
          termsAndConditionsRemoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<TermsAndConditionsRemoteDataSource>(
      () => TermsAndConditionsRemoteDataSourceImpl(apiConsumer: sl()));
}
