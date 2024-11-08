/*
Auth Repository - Outlines the possible auht operations for this app

*/

import 'package:clone_instagram/features/auth/domain/entites/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> loginWithEmailPassword(String email, String password);
  Future<AppUser?> registerWithEmailPassword(
      String email, String password, String name);

  Future<void> logout();

  Future<AppUser?> getCurrentUser();
}
