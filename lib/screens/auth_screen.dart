import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController controllerLogin = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.width > 500
          ? Center(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Row"), Text("Row")]),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome!",
                      style: TextStyle(fontSize: 60),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Log in",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.all(10),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controllerLogin,
                              validator: ((value) =>
                                  checkInput(value, "Login")),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Login",
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              obscureText: true,
                              controller: controllerPassword,
                              validator: ((value) =>
                                  checkInput(value, "Password")),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

String? checkInput(value, String fieldName) {
  if (value == null || value.isEmpty) {
    return "$fieldName не должен быть пустым";
  }
  if (value.length < 2) {
    return "$fieldName должен быть от 2 символов";
  }
  if (value.length >= 30) {
    return "$fieldName должен быть до 20 символов";
  }
  return null;
}
