import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_picture_event.dart';
part 'profile_picture_state.dart';

class ProfilePictureBloc
    extends Bloc<ProfilePictureEvent, ProfilePictureState> {
  ProfilePictureBloc() : super(ProfilePictureInitial()) {
    on<UpdateProfilePictureEvent>(_updateProfilePicture);
  }

  Future<void> _updateProfilePicture(UpdateProfilePictureEvent event,
      Emitter<ProfilePictureState> emitter) async {
    try {
      var image = await getImage();
      if (image == null) {
        return;
      }
      emitter(ProfilePictureLoading());

      FirebaseStorage storage = FirebaseStorage.instance;

      var reference = storage.ref().child('profile_pictures/${event.userId}');

      await reference.putFile(image);
      // allow public access to the file
      await reference.updateMetadata(
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': image.path},
        ),
      );

      String url = await reference.getDownloadURL();

      await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);

      emitter(ProfilePictureLoaded());
    } catch (e) {
      emitter(ProfilePictureError());
    }
  }

  Future<File?> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }
}
