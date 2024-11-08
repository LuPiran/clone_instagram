import 'package:clone_instagram/features/profile/domain/entites/profile_user.dart';

abstract class SearchRepository {
  Future<List<ProfileUser>> searchUsers(String query);
}
