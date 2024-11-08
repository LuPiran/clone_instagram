/*

PROFILE STATES

*/

import 'package:clone_instagram/features/profile/domain/entites/profile_user.dart';

abstract class ProfileState {}

//initial
class ProfileInital extends ProfileState {}

//loading...
class ProfileLoading extends ProfileState {}

//loaded
class ProfileLoaded extends ProfileState {
  final ProfileUser profileUser;
  ProfileLoaded(this.profileUser);
}

//error
class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
