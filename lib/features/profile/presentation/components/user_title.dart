import 'package:clone_instagram/features/profile/domain/entites/profile_user.dart';
import 'package:clone_instagram/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

class UserTitle extends StatelessWidget {
  final ProfileUser user;

  const UserTitle({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.profileImageUrl),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      subtitleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      trailing: Icon(
        Icons.arrow_forward,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(uid: user.uid),
        ),
      ),
    );
  }
}