import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAcceptButton extends StatelessWidget {
  const CustomAcceptButton({
    super.key,
    required this.func,
    this.child,
  });

  final VoidCallback func;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.secondaryContainer),
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.secondary),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: child ?? Center(
              child: Text(
            "Log in",
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          )),
        ),
      ),
    );
  }
}
