import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/presentation/widgets/auth_field.dart';
import 'package:todo_app/presentation/widgets/rounded_small_button.dart';
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
                const Text(
                  'Welcome to Todo app!',
                  style: MyTheme.titleTextStyle,
                ),
                const SizedBox(height: 24),
                Image.asset('assets/backgrounds/bg_login_signup.png'),
                AuthField(
                  controller: emailController,
                  hintText: 'Email',
                  hideText: false,
                ),
                const SizedBox(height: 10),
                AuthField(
                  controller: passwordController,
                  hintText: 'Password',
                  hideText: true,
                ),
                const SizedBox(height: 10),
                RoundedSmallButton(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false).login();
                  },
                  label: 'Login',
                  textColor: MyTheme.blackColor,
                  backGroundColor: MyTheme.whiteColor,
                ),
                const SizedBox(height: 40),
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
                          ..onTap = () async {
                            await Navigator.of(context).pushNamed(signupRoute);
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
