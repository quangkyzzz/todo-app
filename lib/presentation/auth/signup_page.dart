import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/auth_field.dart';
import '../widgets/rounded_small_button.dart';
import '../../themes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onSignUp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: MyTheme.backgroundGreyColor,
        content: Text(
          'Account created success! Please login',
          style: MyTheme.itemSmallTextStyle,
        ),
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pop(context);
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
          'signup',
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
                const SizedBox(height: 10),
                AuthField(
                  controller: passwordController,
                  hintText: 'Password',
                  hideText: true,
                ),
                const SizedBox(height: 10),
                RoundedSmallButton(
                  onTap: onSignUp,
                  label: 'Sign Up',
                  textColor: MyTheme.blackColor,
                  backGroundColor: MyTheme.whiteColor,
                ),
                const SizedBox(height: 40),
                RichText(
                  text: TextSpan(
                    text: "Already have an account?",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: ' Login',
                        style: const TextStyle(
                          color: MyTheme.blueColor,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pop();
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
