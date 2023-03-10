import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/check_input.dart';
import '../utils/custom_accept_button.dart';
import '../utils/custom_input_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: context.width > 550
            ? Center(
                child: Row(children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Theme.of(context).colorScheme.secondaryContainer,
                            Theme.of(context).colorScheme.background
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  "Welcome",
                                  style: TextStyle(fontSize: 60),
                                ),
                                Text(
                                  "Log in",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: LoginForm(),
                      ),
                    ],
                  )),
                ]),
              )
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.secondaryContainer,
                      Theme.of(context).colorScheme.background
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              "Welcome",
                              style: TextStyle(fontSize: 60),
                            ),
                            Text(
                              "Log in",
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Center(child: LoginForm()),
                    ),

                    // const SizedBox(height: 70),
                  ],
                ),
              ));
  }
}

class LoginForm extends StatefulWidget {
  LoginForm();

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _key = GlobalKey<FormState>();

  TextEditingController controllerLogin = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          CustomInputField(
            validator: (value) => checkInput(value, "Login"),
            controller: controllerLogin,
            text: "Login",
          ),
          const SizedBox(height: 10),
          CustomInputField(
            validator: (value) => checkInput(value, "Password"),
            controller: controllerPassword,
            text: "Password",
            obscureText: true,
          ),
          const SizedBox(height: 10),
          CustomAcceptButton(
            child: Center(
                child: Text(
              "Log in",
              style: TextStyle(color: Theme.of(context).colorScheme.background),
            )),
            func: () {
              if (_key.currentState!.validate()) {
                Get.snackbar("tada", "message");
              } else {
                Get.snackbar("User error", "enter correct values");
              }
            },
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                 TextSpan(
                  text: 'Doesn`t have an account? ',
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary)
                ),
                TextSpan(
                  text: 'Register',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

