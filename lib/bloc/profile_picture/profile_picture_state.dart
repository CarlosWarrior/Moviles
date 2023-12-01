part of 'profile_picture_bloc.dart';

sealed class ProfilePictureState extends Equatable {
  const ProfilePictureState();

  @override
  List<Object> get props => [];
}

final class ProfilePictureInitial extends ProfilePictureState {}

final class ProfilePictureLoading extends ProfilePictureState {}

final class ProfilePictureLoaded extends ProfilePictureState {
  ProfilePictureLoaded();
}

final class ProfilePictureError extends ProfilePictureState {}
