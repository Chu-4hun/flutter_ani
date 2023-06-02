import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ani/cubit/auth_cubit.dart';
import 'package:flutter_ani/screens/register_screen.dart';
import 'package:flutter_ani/screens/user_screen.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/UI/custom_input_field.dart';
import '../utils/UI/custom_accept_button.dart';
import '../utils/check_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            Get.snackbar('Ошибка', state.error);
          }
          if (state is AuthSucces) {
            Get.off(() => const UserScreen());
          }
        },
        builder: (context, state) {
          return context.width > 550
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
                              child: const Column(
                                children: [
                                  Text(
                                    "Log in",
                                    style: TextStyle(fontSize: 60),
                                  ),
                                  Text(
                                    "Welcome",
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
                          child: const Column(
                            children: [
                              Text(
                                "Log in",
                                style: TextStyle(fontSize: 60),
                              ),
                              Text(
                                "Welcome",
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
                );
        },
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final _key = GlobalKey<FormState>();

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          CustomInputField(
            validator: (value) => checkInput(value, "Login"),
            controller: _loginController,
            text: "Login",
          ),
          const SizedBox(height: 10),
          CustomInputField(
            icon: LineIcons.key,
            validator: (value) => checkInput(value, "Password"),
            controller: _passwordController,
            text: "Password",
            obscureText: true,
          ),
          const SizedBox(height: 10),
          CustomAcceptButton(
            onPressed: () {
              if (_key.currentState!.validate()) {
                context.read<AuthCubit>().login(
                      _loginController.text,
                      _passwordController.text,
                    );
              } else {
                Get.snackbar("User error", "enter correct values");
              }
            },
            child: Center(
              child: Text(
                "Log in",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.background),
              ),
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'Doesn`t have an account? ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary)),
                TextSpan(
                  text: 'Register',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.to(const RegisterScreen());
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
