import 'package:clone_instagram/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:clone_instagram/features/home/presentation/components/my_drawer_title.dart';
import 'package:clone_instagram/features/profile/presentation/pages/profile_page.dart';
import 'package:clone_instagram/features/search/presentation/pages/search_page.dart';
import 'package:clone_instagram/features/settings/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              //logo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              //Divider line
              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),

              //home tite
              MyDrawerTitle(
                title: "HOME",
                icon: Icons.home,
                onTap: () => Navigator.of(context).pop(),
              ),
              //profile title
              MyDrawerTitle(
                title: "PROFILE",
                icon: Icons.person,
                onTap: () {
                  Navigator.of(context).pop();

                  //get current user id
                  final user = context.read<AuthCubit>().currentUser;
                  String? uid = user!.uid;

                  //Navigator to profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        uid: uid,
                      ),
                    ),
                  );
                },
              ),
              //search title
              MyDrawerTitle(
                title: "SEARCH",
                icon: Icons.search,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage())),
              ),
              //settings title
              MyDrawerTitle(
                title: "SETTINGS",
                icon: Icons.settings,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage())),
              ),
              const Spacer(),
              //logout title
              MyDrawerTitle(
                title: "LOGOUT",
                icon: Icons.logout,
                onTap: () => context.read<AuthCubit>().logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
