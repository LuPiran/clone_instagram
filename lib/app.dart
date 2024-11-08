import 'package:clone_instagram/features/auth/data/firebase_auth_repository.dart';
import 'package:clone_instagram/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:clone_instagram/features/auth/presentation/cubits/auth_states.dart';
import 'package:clone_instagram/features/auth/presentation/pages/auth_page.dart';
import 'package:clone_instagram/features/home/presentation/pages/home_page.dart';
import 'package:clone_instagram/features/post/data/firebase_post_repository.dart';
import 'package:clone_instagram/features/post/presentation/cubits/post_cubit.dart';
import 'package:clone_instagram/features/profile/data/firebase_profile_repository.dart';
import 'package:clone_instagram/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:clone_instagram/features/search/data/firebase_search_repository.dart';
import 'package:clone_instagram/features/search/presentation/cubits/search_cubit.dart';
import 'package:clone_instagram/features/storage/data/firebase_storage_repository.dart';
import 'package:clone_instagram/themes/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*

APP - Root Level

---------------------------------------

Repositories: for the database
  - firestore

Bloc Providers: for state management
  - auth
  - profile
  - post
  - search
  - themme
Check Auth State 
  - unauthenticated  -> auth page(login/register)
  - authenticated -> home page

*/

class MyApp extends StatelessWidget {
  //auth repository
  final firebaseAuthRepo = FirebaseAuthRepository();

  //profile repository
  final firebaseProfileRepo = FirebaseProfileRepository();

  // storage repository
  final firebaseStorageRepo = FirebaseStorageRepository();

  //post repository
  final firebasePostRepo = FirebasePostRepository();

  //search repository
  final firebaseSearchRepo = FirebaseSearchRepository();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //provide cubits to app
    return MultiBlocProvider(
      providers: [
        //Auth cubit
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(authRepository: firebaseAuthRepo)..checkAuth(),
        ),

        //profile cubit
        BlocProvider(
          create: (context) => ProfileCubit(
            profileRepository: firebaseProfileRepo,
            storageRepository: firebaseStorageRepo,
          ),
        ),

        //post cubit
        BlocProvider<PostCubit>(
          create: (context) => PostCubit(
            postRepository: firebasePostRepo,
            storageRepository: firebaseStorageRepo,
          ),
        ),

        //search cubit
        BlocProvider<SearchCubit>(
          create: (context) =>
              SearchCubit(searchRepository: firebaseSearchRepo),
        ),

        //theme cubit
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],

      //bloc builder: themes
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, currentTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: currentTheme,
          //bloc builder: check current auth state
          home: BlocConsumer<AuthCubit, AuthStates>(
            builder: (context, authState) {
              print(authState);

              //unauthenticated  -> auth page(login/register)
              if (authState is Unauthenticated) {
                return const AuthPage();
              }

              //authenticated -> home page
              if (authState is Authenticated) {
                return const HomePage();
              }

              //loading
              else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      state.message,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
