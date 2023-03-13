import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.controller,
    this.text,
    this.icon,
    this.obscureText,
    this.validator, this.autovalidateMode,
  });

  final TextEditingController controller;
  final String? text;
  final IconData? icon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode?? AutovalidateMode.disabled,
      validator: validator,
      obscureText: obscureText ?? false,
      controller: controller,
      // validator: ((value) => checkInput(value, "Login")),
      decoration: InputDecoration(
        prefixIcon: Icon(icon ?? LineIcons.user),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        labelText: text ?? "Login",
      ),
    );
  }
}
