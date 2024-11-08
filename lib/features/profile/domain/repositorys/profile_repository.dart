/*

Profile Repository

*/

import 'package:clone_instagram/features/profile/domain/entites/profile_user.dart';

abstract class ProfileRepository {
  Future<ProfileUser?> fetchUserProfile(String uid);
  Future<void> updateProfile(ProfileUser updatedProfider);
  Future<void> toggleFolow(String currentUid, String targetUid);
}
