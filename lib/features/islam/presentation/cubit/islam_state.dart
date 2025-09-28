part of 'islam_cubit.dart';

abstract class IslamState extends Equatable {
  const IslamState();

  @override
  List<Object> get props => [];
}

class IslamInitial extends IslamState {}

class InviteToIslamLoadingState extends IslamState {}

class InviteToIslamSuccessState extends IslamState {
  final String message;
  const InviteToIslamSuccessState({required this.message});
}

class InviteToIslamErrorState extends IslamState {
  final String message;
  const InviteToIslamErrorState({required this.message});
}

class GetIntroductionsLoadingState extends IslamState {}

class GetIntroductionsSuccessState extends IslamState {
  final String message;
  const GetIntroductionsSuccessState({required this.message});
}

class GetIntroductionsErrorState extends IslamState {
  final String message;
  const GetIntroductionsErrorState({required this.message});
}




class SearchInDefinitionsState extends IslamState {
  final List<DefinitionModel> definitions;
  const SearchInDefinitionsState({required this.definitions});

  @override
  List<Object> get props => [definitions];
}

class ShareDefinitionLoadingState extends IslamState {}
class ShareDefinitionSuccessState extends IslamState {
  final String message;
  const ShareDefinitionSuccessState({required this.message});
}

class ShareDefinitionErrorState extends IslamState {
  final String message;
  const ShareDefinitionErrorState({required this.message});
}

