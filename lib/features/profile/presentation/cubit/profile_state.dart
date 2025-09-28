part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class GetProfileDataLoadingState extends ProfileState {}

class GetProfileDataLoadedState extends ProfileState {
  final UserModel profile;

  const GetProfileDataLoadedState({required this.profile});

  @override
  List<Object> get props => [profile];
}

class GetProfileDataErrorState extends ProfileState {
  final String message;
  const GetProfileDataErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class UpdateProfileDataLoadingState extends ProfileState {}

class UpdateProfileDataSuccessState extends ProfileState {
  final UserModel profile;
  final String message;

  const UpdateProfileDataSuccessState(
      {required this.profile, required this.message});

  @override
  List<Object> get props => [profile];
}

class UpdateProfileDataErrorState extends ProfileState {
  final String message;
  const UpdateProfileDataErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class UploadImageLoadingState extends ProfileState {}
class UploadImageSuccessState extends ProfileState {
  final String message;
  const UploadImageSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class UploadImageErrorState extends ProfileState {
  final String message;
  const UploadImageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}