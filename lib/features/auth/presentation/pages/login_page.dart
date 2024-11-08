/*
LOGIN PAGE

On this page, an existing user can login with their

- email
- pw

----------------------------------------------------------------------

Once the user successfuly logs in, they will be redirected to home page.

If user doesn't have an account yet, they can go to register page  from here to create one.

*/

import 'package:clone_instagram/features/auth/presentation/components/my_button.dart';
import 'package:clone_instagram/features/auth/presentation/components/my_text_field.dart';
import 'package:clone_instagram/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  //Login
  void login() {
    //prepare email e pw
    final String email = emailController.text;
    final String pw = pwController.text;

    //auth cubit
    final authCubit = context.read<AuthCubit>();

    //ensure that the email e pw fiels are not empity
    if (email.isNotEmpty && pw.isNotEmpty) {
      //login!!!
      authCubit.login(email, pw);
    } else {
      //Display error if some fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please enter both email and password",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BODY
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Logo
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Icon(
                      Icons.lock_open_rounded,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 50),
                  //Welcome back msg
                  Text(
                    "Welcome back, you've been missed!",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  //email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 10),
                  //pw textfield
                  MyTextField(
                    controller: pwController,
                    hintText: 'Password',
                    isSecret: true,
                  ),
                  const SizedBox(height: 25),
                  //login button
                  MyButton(
                    onTap: login,
                    text: 'Login',
                  ),
                  const SizedBox(height: 50),
                  //Not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member? ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Regidter now",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
