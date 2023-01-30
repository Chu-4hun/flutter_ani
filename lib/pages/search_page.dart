import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerOutlined = TextEditingController();
    
    return Scaffold(
      appBar: new AppBar(
        flexibleSpace: SafeArea(
          child: TextField(
            controller: _controllerOutlined,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              labelText: 'Outlined',
              hintText: 'hint text',
              helperText: 'supporting text',
              errorText: 'error text',
              border: const OutlineInputBorder(),
              filled: true,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [Text("data")],
        ),
      ),
    );
  }
}
