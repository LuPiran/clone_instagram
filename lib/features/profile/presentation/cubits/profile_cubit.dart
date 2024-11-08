import 'dart:typed_data';

import 'package:clone_instagram/features/profile/domain/entites/profile_user.dart';
import 'package:clone_instagram/features/profile/domain/repositorys/profile_repository.dart';
import 'package:clone_instagram/features/profile/presentation/cubits/profile_state.dart';
import 'package:clone_instagram/features/storage/domain/storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  final StorageRepository storageRepository;

  ProfileCubit({
    required this.profileRepository,
    required this.storageRepository,
  }) : super(ProfileInital());

  //fetch user profile using repository -> useful for loading single profile pages
  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepository.fetchUserProfile(uid);

      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError("User not found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  //return user profile given uid -> useful for loading many profiles for posts
  Future<ProfileUser?> getUserProfile(String uid) async {
    final user = await profileRepository.fetchUserProfile(uid);
    return user;
  }

  //update bio and or profile picture
  Future<void> updateProfile({
    required String uid,
    String? newBio,
    Uint8List? imagesWebBytes,
    String? imageMobilePath,
  }) async {
    emit(ProfileLoading());

    try {
      //fetch current profile first
      final currentUser = await profileRepository.fetchUserProfile(uid);

      if (currentUser == null) {
        emit(ProfileError("Failed to fetch user for update"));
        return;
      }

      //profile picture update
      String? imageDownloadUrl;

      //ensure there is an image
      if (imagesWebBytes != null || imageMobilePath != null) {
        //for mobile
        if (imageMobilePath != null) {
          //upload
          imageDownloadUrl = await storageRepository.uploadProlifeImageMobile(
              imageMobilePath, uid);
        }
        //for web
        else if (imagesWebBytes != null) {
          //upload
          imageDownloadUrl = await storageRepository.uploadProlifeImageWeb(
              imagesWebBytes, uid);
        }

        if (imageDownloadUrl == null) {
          emit(ProfileError("Failed to upload image"));
          return;
        }
      }

      //upate new profile
      final updateProfile = currentUser.copyWith(
        newBio: newBio ?? currentUser.bio,
        newProfileImageUrl: imageDownloadUrl ?? currentUser.profileImageUrl,
      );

      //update in repository
      await profileRepository.updateProfile(updateProfile);

      //re-fetch the updated profile
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError("Error updating profile: $e"));
    }
  }

  //toggle follow/unfollow
  Future<void> toggleFolow(String currentUserUid, String targetUserUid) async {
    try {
      await profileRepository.toggleFolow(currentUserUid, targetUserUid);
    } catch (e) {
      emit(ProfileError("Error toggling follow: $e"));
    }
  }
}
