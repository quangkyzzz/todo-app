import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentation/widgets/auth_field.dart';
import 'package:todo_app/presentation/widgets/rounded_small_button.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/themes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onLogIn() {
    Provider.of<UserProvider>(context, listen: false).login();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'login',
          style: MyTheme.titleTextStyle,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AuthField(
                  controller: emailController,
                  hintText: 'Email',
                  hideText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                AuthField(
                  controller: passwordController,
                  hintText: 'Password',
                  hideText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedSmallButton(
                  onTap: onLogIn,
                  label: 'Login',
                  textColor: MyTheme.blackColor,
                  backGroundColor: MyTheme.whiteColor,
                ),
                const SizedBox(
                  height: 40,
                ),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: ' Sign up',
                        style: const TextStyle(
                          color: MyTheme.blueColor,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed(signupRoute);
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
