part of 'profile_picture_bloc.dart';

sealed class ProfilePictureEvent extends Equatable {
  const ProfilePictureEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfilePictureEvent extends ProfilePictureEvent {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  UpdateProfilePictureEvent();
}
