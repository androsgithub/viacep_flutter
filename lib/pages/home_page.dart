import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

buscarCep() {}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("V I A  C E P - F L U T T E R"),
      ),
      body: const Column(
        children: [
          TextField(),
          TextButton(onPressed: buscarCep, child: Text("Buscar"))
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
